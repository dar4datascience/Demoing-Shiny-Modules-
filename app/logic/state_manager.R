box::use(
  R6[R6Class],
)


#' @export
manager_r6 <- function() {
  R6Class(
    "Manager",
    public = list(
      variable_name = NULL,
      set_variable = function(variable_name) {
        self$variable_name <- variable_name
      }
    )
  )
}
