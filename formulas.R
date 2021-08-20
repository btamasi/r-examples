## Some utility functions for editing formulas

## A complicated example
ff <- Surv(y, cens) | s1 + s2 ~ s(x0) + s(x1, k = nn, by = fac) + (x3 | g) + x2
environment(ff) <- new.env()

## Disassemble a formula and turn it into a list with the same nested
## structure
## @param f Formula or call.
disass_formula <- function(f) {
  if (length(f) == 1) return(f)
  lapply(f, disass_formula)
}

disass_formula(ff)

## Substitute operators in a formula
## @param f Formula or call.
## @param what Terms to substitute.
## @param with Term to substitute with.
subst_formula <- function(f, what = c("|", "||"), with = "+") {
  if (is.call(f)) {
    for (i in seq_along(f)) {
      f[[i]] <- subst_formula(f[[i]], what = what, with = with)
    }
  } else {
    if (any(sapply(what, function(x) f == as.name(x))))
      f <- as.name(with)
  }
  return(f)
}

subst_formula(ff)

## Helper function to recursively drop terms from a fomula
## @param f Formula or call.
## @param what Things to remove from \code{f}.
## @note Adapted from \code{\link[lme4]{nobars_}}.
drop_terms <- function(f, what = c("|", "||", "s", "te", "ti", "t2")) {
  chk <- function(ff) any(sapply(what, function(x) ff == as.name(x)))

  if (!any(what %in% all.names(f))) return(f)
  if (is.call(f) && chk(f[[1]])) return(NULL)
  if (length(f) == 2) {
    if (is.null(f[[2]] <- drop_terms(f[[2]], what = what))) return(NULL)
    return(f)
  }
  f2 <- drop_terms(f[[2]], what = what)
  f3 <- drop_terms(f[[3]], what = what)
  if (is.null(f2)) return(f3)
  if (is.null(f3)) return(f2)
  f[[2]] <- f2
  f[[3]] <- f3
  return(f)
}

## Remove terms from a formula
## @param f Formula or call.
## @param what Things to remove from \code{f}.
## @param right_only Remove only from the right side of \code{f}.
## @note Adapted from \code{\link[lme4]{nobars}}.
remove_from_formula <- function(f, what = c("|", "||", "s", "te", "ti", "t2"),
                                right_only = TRUE) {
  env <- environment(f)
  if (is(f, "formula") && length(f) == 3) {
    nfr <- drop_terms(f[[3]], what)
    nfl <- if (!right_only) drop_terms(f[[2]], what) else f[[2]]
    if (is.null(nfl) && is.null(nfr))
      nf <- ~1
    else if (is.null(nfl))
      nf <- reformulate(deparse(nfr))
    else if (is.null(nfr))
      nf <- reformulate("1", response = deparse(nfl))
    else
      nf <- reformulate(deparse(nfr), response = deparse(nfl))
  } else {
    nf <- drop_terms(f, what)
  }
  if (is.null(nf))
    nf <- if (is(f, "formula")) ~1 else 1
  if (is(nf, "formula"))
    environment(nf) <- env
  return(nf)
}

remove_from_formula(ff)
remove_from_formula(y ~ s(x) + (x | g))
remove_from_formula(~ s(x) + (x | g))
ff2 <- y ~ s(x) + (x | g)
remove_from_formula(ff2[[3]])

remove_from_formula(Surv(y, cens) | s ~ x0 + I(x1^2) + s(x2, k = 10) +
                      (x0 + x2 | g) + ti(x22, x23) + x10 + (xx || g2),
                    right_only = FALSE)

remove_from_formula(y | a ~ s(x) + (x | g), right_only = FALSE)

## Recursively remove named arguments from the formula
## @param f Formula or call.
## @param keep Keep these named arguments.
remove_named_formula <- function(f, keep = NULL) {
  if (is.call(f)) {
    if (!is.null(nm <- names(f))) {
      f <- f[!is.na(match(nm, c("", keep)))]
    }
    for (i in seq_along(f)) {
      f[[i]] <- remove_named_formula(f[[i]], keep = keep)
    }
  }
  return(f)
}

## Create fake fromula to fool \code{\link[stats]{model.frame}} and related
## utility functions
## @param f Formula or call.
## @param split_left Operator we allow to split terms of the left side of the
## formula on (if there's any).
## @param omit Variables to omit.
## @param keep_names Remove named arguments except these.
fake_formula <- function(f, split_left = "|", omit = NULL, keep_names = "by") {
  env <- environment(f)
  f <- remove_named_formula(f, keep = keep_names)
  if (is(f, "formula") && length(f) == 3) {
    rv <- paste(deparse(f[[2]], width.cutoff = 500L), collapse = " ")
    rv <- strsplit(rv, split = split_left, fixed = TRUE)[[1]][1]
    omit <- c(omit, all.vars(parse(text = rv)))
  } else {
    rv <- NULL
    omit <- c(omit, NULL)
  }
  vn <- all.vars(f)
  vn <- vn[is.na(match(vn, omit))]
  if (length(vn) == 0) vn <- "1"
  ff <- reformulate(vn, response = rv)
  if (!is(f, "formula"))
    ff <- ff[[2]]
  else
    environment(ff) <- env
  return(ff)
}

fake_formula(ff)
fake_formula(Surv(y, c) | s1 + s2 ~ s(x, k = 10) + x + (x1 + x2 || g))
fake_formula(ff[[3]])
fake_formula(~ x1 + ti(x1, x2) + (x1 | g))
fake_formula(y ~ . + (x1 | g))
fake_formula(y ~ . + (x1 | g), omit = ".")
