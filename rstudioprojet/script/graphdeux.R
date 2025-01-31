# Ce deuxième graph permet de voir 

musiques <- read.csv("data/musiques.csv")

ggplot(data = musiques, aes(x = date_prod,
                             y = style,
                             colour = genre,
                            ))  +
  geom_point() + 
  labs(x = "date de production", y = "style", 
       title = "Relations en genre, style et date de production",
       subtitle = "sur 66 musiques",
       caption = "Source : playlist de florine, année 2024") +
  theme_minimal()