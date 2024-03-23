box::use(
  shiny[bootstrapPage, div, moduleServer, NS, renderUI, tags, uiOutput, plotOutput, varSelectInput, renderPlot, ],
  bslib[bs_theme, card, card_header,page_sidebar, font_google],
  palmerpenguins[penguins],
  ggplot2[aes, theme_set, theme_bw]
)

box::use(
  app/view/plot_histogram,
  app/view/render_plot_in_card
)


#' @export
ui <- function(id){
  ns <- NS(id)
  page_sidebar(
    title = "Penguins Demo dashboard",
    sidebar = plot_histogram$ui(ns("compute_histogram")),
    theme = bs_theme(
      bootswatch = "darkly",
      base_font = font_google("Inter"),
      navbar_bg = "#25443B"
    ),
    !!!list(
      render_plot_in_card$ui(ns("bill_length"), "Bill Length"),
      render_plot_in_card$ui(ns("bill_depth"), "Bill Depth"),
      render_plot_in_card$ui(ns("body_mass"), "Body Mass")
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
    # module sidebar
    gg_plot <- plot_histogram$server("compute_histogram")

      # module plot bill length
      render_plot_in_card$server("bill_length", gg_plot, bill_length_mm)
      # module plot bill depth
      render_plot_in_card$server("bill_depth", gg_plot, bill_depth_mm)
      # module plot body mass
      render_plot_in_card$server("body_mass", gg_plot, body_mass_g)

  })
}
