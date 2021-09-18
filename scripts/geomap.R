geomap <- function(data, variable1, variable2, rng, color_low, color_high, title, subtitle, legend_title, caption) { 
  
  theme_set(theme_map(base_size = 14))
  
  p <- ggplot(data) +
    geom_sf(mapping = aes(fill={{variable1}}, text=paste({{variable2}}, {{variable1}})) ) +
    scale_fill_continuous(low = color_low,
                          high = color_high,
                          name = legend_title,
                          limits = c(floor(rng[1]), ceiling(rng[2]))) + 
    coord_sf() +
    theme(legend.position = c(0.8, 0.8))
  
  ggplotly(p, tooltip = "text") %>% 
    style(hoverlabel = list(bgcolor = "white")) %>% 
    layout(title = list(text = paste0({title},
                                      '<br>',
                                      '<sup>',
                                      {subtitle},
                                      '</sup>')),
           font = list(size = 12),
           margin = list(t = 100)) # top margin
  
}

# TODO caption
# annotations = 
#            list(x = 0.5, y = -0.75, #position of text adjust as needed 
#                 text = caption, 
#                 showarrow = F, xref='paper', yref='paper', 
#                 xanchor='right', yanchor='auto', xshift=0, yshift=0,
#                 font=list(size=15, color="grey"))) 