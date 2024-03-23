box::use(
  shiny[moduleServer,
        NS,
        textOutput,
        renderText,
        reactive,
        textInput,
        observeEvent,
        bindEvent],
  bslib[card, sidebar, layout_sidebar],
)

box::use(
  app/logic/state_manager[manager_r6],
)

#' @export
ui <- function(id) {
  ns <- NS(id)
  card(
    full_screen = TRUE,
    title = "Print Value Written",
    layout_sidebar(
      fillable = TRUE,
      sidebar = sidebar(
        textInput(
          ns("mytext"),
          "Your text")
      ),
      textOutput(ns("message"))
    )
  )
}

#' @export
server <- function(id) {
  moduleServer(id, function(input, output, session) {

    hello_r6 <- manager_r6()$new()

    observeEvent(input$mytext, {

      hello_r6$set_variable(input$mytext)
    })

   output$message <- renderText({
     hello_r6$variable_name
   }) |>
     bindEvent(input$mytext) #needs a eactive native value
  })
}
