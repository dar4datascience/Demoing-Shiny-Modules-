box::use(
  shiny[bootstrapPage,
        div,
        moduleServer,
        NS,
        tags,
        enableBookmarking        ],
         bslib[bs_theme,
               page_navbar,
               font_google, nav_panel],
         palmerpenguins[penguins],
         ggplot2[aes, theme_set, theme_bw], )

box::use(app / view / plot_histogram,
         app / view / render_plot_in_card,
         app / view / render_text_in_card,)


#' @export
ui <- function(id) {
  ns <- NS(id)
  enableBookmarking()
  page_navbar(
    title = "Penguins Demo dashboard",
    sidebar = plot_histogram$ui(ns("compute_histogram")),
    theme = bs_theme(
      bootswatch = "superhero",
      base_font = font_google("Inter"),
      "navbar-bg" = "#25443B"
    ),
    nav_panel("Plots",
    !!!list(
      render_plot_in_card$ui(ns("bill_length"), "Bill Length"),
      render_plot_in_card$ui(ns("bill_depth"), "Bill Depth"),
      render_plot_in_card$ui(ns("body_mass"), "Body Mass")
    )
    ),
    nav_panel("Demo R6",
              render_text_in_card$ui(ns("r6_demo"))
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

    # R6 Demo
    render_text_in_card$server("r6_demo")
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
