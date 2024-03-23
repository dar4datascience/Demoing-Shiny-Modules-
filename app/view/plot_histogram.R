box::use(
  shiny[moduleServer, NS, reactive, varSelectInput],
  ggplot2[theme_set, ggplot, aes, geom_density, theme_bw, element_blank, theme],
  palmerpenguins[penguins],
)

#' @export
ui <- function(id) {
  ns <- NS(id)
  varSelectInput(
    ns("color_by"), "Color by",
    penguins[c("species", "island", "sex")],
    selected = "species"
  )
}

#' @export
server <- function(id) {
  moduleServer(id, function(input, output, session) {
     reactive({
      ggplot(penguins) +
        geom_density(aes(fill = !!input$color_by), alpha = 0.2) +
        theme(axis.title = element_blank())
    })
  })
}
