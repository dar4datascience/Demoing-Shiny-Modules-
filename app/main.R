box::use(
  shiny[bootstrapPage, div, moduleServer, NS, renderUI, tags, uiOutput, plotOutput, varSelectInput, renderPlot, reactive],
  bslib[bs_theme, card, card_header,page_sidebar, font_google],
  ggplot2[theme_set, ggplot, aes, geom_density, theme_bw, element_blank, theme],
  palmerpenguins[penguins]
)


#' @export
ui <- function(id){
  ns <- NS(id)
  page_sidebar(
    title = "Penguins Demo dashboard",
    sidebar = varSelectInput(
      ns("color_by"), "Color by",
      penguins[c("species", "island", "sex")],
      selected = "species"
    ),
    theme = bs_theme(
      bootswatch = "darkly",
      base_font = font_google("Inter"),
      navbar_bg = "#25443B"
    ),
    !!!list(
      card(
        full_screen = TRUE,
        card_header("Bill Length"),
        plotOutput(ns("bill_length"))
      ),
      card(
        full_screen = TRUE,
        card_header("Bill depth"),
        plotOutput(ns("bill_depth"))
      ),
      card(
        full_screen = TRUE,
        card_header("Body Mass"),
        plotOutput(ns("body_mass"))
      )
    )
  )
}

# Enable thematic
thematic::thematic_shiny(font = "auto")

# Change ggplot2's default "gray" theme
theme_set(theme_bw(base_size = 16))

#' @export
server <- function(id) {
  moduleServer(id, function(input, output, session) {

    # New server logic (removes the `+ theme_bw()` part)
      gg_plot <- reactive({
        ggplot(penguins) +
          geom_density(aes(fill = !!input$color_by), alpha = 0.2) +
          theme(axis.title = element_blank())
      })

      #
      output$bill_length <- renderPlot(gg_plot() + aes(bill_length_mm))
      output$bill_depth <- renderPlot(gg_plot() + aes(bill_depth_mm))
      output$body_mass <- renderPlot(gg_plot() + aes(body_mass_g))

  })
}
