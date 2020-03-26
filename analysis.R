#loading library

library(tidyverse)
library(ggrepel)
library(ggthemes)

#loading Rdata object murders

load("rdas/murders.rda")

#Computing average murder rate in USA

r <- murders %>% summarize(rate = sum(total) / sum(population) * 10 ^ 6) %>% pull(rate)

#Data Visualization Code

p <- murders %>% ggplot() 

p + geom_point(aes(x = population / 10 ^ 6, y = total, col = region), size = 3) + 
  geom_text_repel(aes(x = population / 10 ^ 6, y = total, label = abb), nudge_x = 0.01) +
  geom_abline(intercept = log10(r),lty = 2, color = "darkgrey") +
  scale_x_continuous(trans = "log10") +
  scale_y_continuous(trans = "log10") +
  xlab("Populations in millions (log scale)") +
  ylab("Total number of murders (log scale)") +
  ggtitle("US Gun Murders in 2010") +
  scale_color_discrete(name = "Region") +
  theme_few()

#Saving RPlot

ggsave("figs/gun-murders.png")
