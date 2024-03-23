box::use(
  shiny[moduleServer, NS, renderPlot, plotOutput, req],
  bslib[card, card_header],
  ggplot2[aes],
)

#' @export
ui <- function(id, card_ht) {
  ns <- NS(id)
  card(
    full_screen = TRUE,
    card_header(card_ht),
    plotOutput(ns("plot"))
  )
}

#' @export
server <- function(id, gg_plot, variable) {
  moduleServer(id, function(input, output, session) {
    output$plot <- renderPlot({
      req(gg_plot)
      gg_plot() + aes({{ variable }})
    })
  })
}
