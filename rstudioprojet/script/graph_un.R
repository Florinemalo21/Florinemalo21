#Installation des packages pour les graphiques
 install.packages("ggplot2")
 install.packages("plotly")
 install.packages("GGally")

# chargement du package
library(ggplot2)

#défintion de "musiques" comme la data utilisée pour le graph
musiques <- read.csv("data/musiques.csv")

# définition des axes x et y, ici pour faire une comparaison entre date de production et style
ggplot(data = musiques, aes(x = date_prod, y = style))

# Un joli graph avec un thème sombre
ggplot(data = musiques, aes(x = date_prod, 
                         y = style,
                        ))  +
  geom_point() + 
  labs(x = "date de production", 
       y = "style", 
       title = "Comparaison styles des musiques et leur date",
       subtitle = "66 musiques",
       caption = "Source : playlist de florine, année 2024")+
  theme_dark()


##########################################################


# ET MAINTENANT, on va faire la comparaison entre genre et année de production

#défintion de "musiques" comme la data utilisée pour le graph
musiques <- read.csv("data/musiques.csv")

# définition des axes x et y, ici pour faire une comparaison entre date de production et style
ggplot(data = musiques, aes(x = date_prod, y = genre))

# Un graph avec un thème clair
ggplot(data = musiques, aes(x = date_prod, 
                            y = genre,
                           
))  +
  geom_point() + 
  labs(x = "date de production", 
       y = "genre", 
       title = "Comparaison genres des musiques et leur date",
       subtitle = "66 musiques",
       caption = "Source : playlist de florine, année 2024")+
  theme_minimal()


##########################################################


# ET MAINTENANT, on va faire la comparaison entre genre et ajout à la playlist

#défintion de "musiques" comme la data utilisée pour le graph
musiques <- read.csv("data/musiques.csv")

# définition des axes x et y, ici pour faire une comparaison entre genre et date d'ajout
ggplot(data = musiques, aes(x = mois_ajout, y = genre))

# Un graph avec un thème clair
ggplot(data = musiques, aes(x = mois_ajout, 
                            y = genre,
                            
))  +
  geom_point() + 
  labs(x = "mois d'ajout", 
       y = "genre", 
       title = "Comparaison genres des musiques et leur mois d'ajout",
       subtitle = "66 musiques",
       caption = "Source : playlist de florine, année 2024")+
  theme_minimal()

#####################on peut même faire un graph interactif avec l'aide de plotly

library(plotly)

fig <-
  ggplot(data = musiques, aes(x = mois_ajout, y = genre)) +
  geom_point(alpha = 0.5) + 
  theme_bw()
labs(x = "mois d'ajout", 
     y = "genre", 
     title = "Graph interactif des genres et mois d'ajout",
     subtitle = "c'est interactif :)",
     caption = "Source : playlist de florine, année 2024")
ggplotly(fig)

##############################################################################


# ET MAINTENANT, les deux en même temps

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


##############################################################################

# ET MAINTENANT, on ajoute le mois d'ajout à tout

musiques <- read.csv("data/musiques.csv")

ggplot(data = musiques, aes(x = mois_ajout,
                            y = style,
                            colour = date_prod , 
                            size = genre,
))  +
  geom_point() + 
  labs(x = "mois d'ajout à la playlist", y = "style", 
       title = "Relations entre genre, style, date de production et date d'ajout",
       subtitle = "sur 66 musiques",
       caption = "Source : playlist de florine, année 2024") +
  theme_minimal()


##############################################################################




# on va prendre moins de données et on va voir quelles chansons ont des paroles en lien avec leur style et leur genre

# ET MAINTENANT on commence par voir la proportion des chansons avec paroles

musiques <- read.csv("data/musiques.csv")

ggplot(data = musiques, aes(y = type_paroles)) + geom_boxplot()


################################# on peut aussi le voir sous la forme d'un camembet un peu plus beau
#il faut dabord charger les libraries

library(ggplot2)
library(dplyr)


data <- data.frame(
  type_paroles = c("Paroles", "Instrumental"),
  n = c(59, 7) # Comptage des musiques
)

# Calcul des proportions et des positions des labels
data <- data %>%
  mutate(
    prop = n / sum(n) * 100,              # Calcule les proportions en pourcentage
    ypos = cumsum(prop) - (prop / 2)      # Position des labels au centre de chaque tranche
  )

# Création du super camembert
ggplot(data, aes(x = "", y = prop, fill = type_paroles)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar("y", start = 0) +
  theme_void() +
  labs(
    title = "Proportion de musiques avec paroles et instrumentaux",
    subtitle = "Un beau camembert",
    caption = "Source : playlist de Florine, année 2024"
  ) +
  geom_text(aes(y = ypos, label = n), color = "white", size = 4)




###################################### on peut aussi faire d'autres camemberts variés


data <- data.frame(
  genre = c("alternatif", "country", "electro", "folk", "jazz", "pop", "punk", "reggae", "rock", "variété"),
  n = c(29, 3, 1, 5, 3, 6, 2, 1, 11, 5) # Comptage des musiques
)

# Calcul des proportions
data <- data %>%
  mutate(
    prop = n / sum(n) * 100  # Proportions
  )

# Création du graphique en camembert sans les labels parce que cest mieux sans 
ggplot(data, aes(x = "", y = prop, fill = genre)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar("y", start = 0) +
  theme_void() +
  labs(
    title = "Proportion des genres dans la playlist",
    subtitle = "Un beau camembert sans labels cette fois",
    caption = "Source : playlist de Florine, année 2024"
  )



######################### On quitte le monde des camemberts et maintenant comparaison avec le style et le genre

ggplot(data = musiques, aes(x = style,
                            y = genre , 
                            colour = type_paroles
                            
                          
))  +
  geom_point() + 
  labs(x = "style", y = "genre", 
       title = "Relations entre genre, style et paroles",
       subtitle = "sur 66 musiques",
       caption = "Source : playlist de florine, année 2024") +
  theme_minimal()


###création de donuts ! 

#########################################################################################








# compter automatiquement combien il y a d'éléments
data <- musiques %>%
  count(mode_decouverte)

print(data)



library(ggplot2)
library(dplyr)

# Création des données
data <- data.frame(
  category = c("Arcane", "Deltarune", "Derry girls", "GTAVI", "Lorelei and the laser eyes",
               "Orange is the new black", "The last of us", "The last of us II", "ami", 
               "famille", "mindcop", "moi", "stranger things"),
  n = c(3, 2, 1, 1, 1, 1, 1, 3, 6, 6, 1, 38, 2) # Fréquence de chaque catégorie
)

# Calcul des proportions et positions
data <- data %>%
  mutate(
    fraction = n / sum(n),         # Proportion
    ymax = cumsum(fraction),       # Haut de chaque tranche
    ymin = c(0, head(ymax, -1))    # Bas de chaque tranche
  )

# Création du Donut 
ggplot(data, aes(ymax = ymax, ymin = ymin, xmax = 4, xmin = 2.5, fill = category)) +
  geom_rect() +
  coord_polar(theta = "y") + 
  xlim(c(2, 4)) +  # Création du trou au centre 
  theme_void() + 
  labs(
    title = "Moyen de découverte de la musique",
    subtitle = "Un beau donut",
    caption = "Source : ma playlist (66 musiques)"
  ) +
  scale_fill_manual(values = c("#FFFF99", "#56B4E9", "#003333", "#669900", 
                               "#CC99CC", "#FF9966", "#CC0066", "#999999",
                               "#CCFFCC", "#FF6600", "#FF0000", "#660033", "#993333"))

#les couleurs viennent de html color chart





########################### Nouveau donut mais cette fois-ci on regroupe les modes de découverte




# On prend les données en additionnant les catégories
data <- data.frame(
  category = c("Jeux-vidéo", "série", "personne"),
  n = c(9, 7 ,50 ) 
)

# Calcul des proportions et positions
data <- data %>%
  mutate(
    fraction = n / sum(n),         # Proportion
    ymax = cumsum(fraction),       # Haut de chaque tranche
    ymin = c(0, head(ymax, -1))    # Bas de chaque tranche
  )

# Création du Donut
ggplot(data, aes(ymax = ymax, ymin = ymin, xmax = 4, xmin = 2.5, fill = category)) +
  geom_rect() +
  coord_polar(theta = "y") + 
  xlim(c(2, 4)) +  # Création du trou au centre (donut)
  theme_void() + 
  labs(
    title = "Moyen de découverte de la musique",
    subtitle = "Selon les grandes catégories (jeux-vidéo, personne et série)",
    caption = "Source : ma playlist (66 musiques)"
  ) +
  scale_fill_manual(values = c("#CCFFFF", "#6633FF", "#CC66FF"))


