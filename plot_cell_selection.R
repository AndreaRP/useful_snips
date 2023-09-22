## Credit to https://gist.github.com/aagarw30/1a86725add60b9dae42fbb44b8e94817
## Load required packages 

library("plotly")
library("ggplot2")
library("shiny")

## Defining a key column in mtcars which will be used for event handling in event_data()
# mtcars$key <- row.names(mtcars)
# tsnedummy <- readRDS("/home/ar2747/YaleOneDrive/projects/neumap_lps/reports/rdata/neumap_lps_all_clusters_tsnedummy.rds")
plot_chunk <- readRDS("/home/ar2747/YaleOneDrive/projects/neumap_lps/reports/rdata/inflammation_trajectory_subset_meta.rds")
plot_chunk$key <- rownames(plot_chunk)
# plot_chunk <- tsnedummy[which(tsnedummy$UMAP_1>=0 &tsnedummy$UMAP_1<=5 & tsnedummy$UMAP_2<=6 & tsnedummy$UMAP_2 >=-4), c("key", "UMAP_1", "UMAP_2", "Sample_Name")]
# plot_chunk <- tsnedummy[which(tsnedummy$integrated_snn_res.0.2==4),]

### Ui code begins below
ui <- fluidPage(
  h1("Interactive data point selection with ggplotly/plotly"),
  h4("Subset the dataset using the data points selected from the chart. Drag and select one or multi data points"),
  br(),
  ## Plotly plot display
  plotlyOutput("plot", height = "600px", width = "600px"),
  # img(src='/home/ar2747/YaleOneDrive/projects/neumap_lps/reports/figures/03_samples_samples_blank/umap_neumap_lps_pdac_surface_plot-1.png', align = "right", height="400px", width="800px"),
  ##Lil' button to save the dots
  actionButton("do", "Save"),
  ## Data point information display post click
  verbatimTextOutput("click")
)


## Server side code begins below
server <- function(input, output, session) {
  
  ## ggplotly scatter plotblob:https://teams.microsoft.com/96217e4b-f53e-48e3-8128-a785e87dccaa
  output$plot <- renderPlotly({
    
    myplot <- ggplot(plot_chunk, aes(x = UMAP_1, 
                                 y = UMAP_2, 
                                 key = key)) + geom_point() +
                                 xlim(min(tsnedummy$UMAP_1), max(tsnedummy$UMAP_1)) +
                                 ylim(min(tsnedummy$UMAP_2), max(tsnedummy$UMAP_2)) 
    ## in above code line, use the argument key inside ggplot which will be used for event handling
    ggplotly(myplot) %>%  
      # partial_bundle() %>%
      layout(dragmode = "lasso")
    
  })
  
  ## returns the data related to data points selected by the user
  output$click <- renderPrint({
    
    
    ## Click_data will have the keys (row identifiers) corresponding to selected data points
    click_data <- event_data("plotly_selected")
    # Write the data
    observeEvent(input$do, {
      write.csv(click_data, "/home/ar2747/YaleOneDrive/projects/neumap_lps/reports/files/selection_zones/cell_ids.csv")
    })
    ## Event mode options. There are many more to experiment
    ## plotly_click - click on one data point
    ##  Plotly_selected - multi point select
    
    if(is.null(click_data)) 
      "No data points selected on scatter plot..." 
    else 
      filter(plot_chunk, key %in% click_data$key) %>% select(-key)
    ## Subsetting in above step based on selected data points and removing the key column
    
  })
}
shinyApp(ui, server)
