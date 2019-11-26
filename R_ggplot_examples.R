# Boxplot
ggplot(global_data, aes(x = as.factor(real_period), y = estimated_period)) +
  geom_boxplot(aes(fill = algorithm), position = position_dodge(0.9)) +
  scale_fill_manual(values = c("#999999", "#E69F00")) +
  blank_background

# Violin plot with dots 
ggplot(global_data, aes(x = as.factor(real_period), y = estimated_period)) +
  geom_violin(aes(fill = algorithm), trim = FALSE) + 
  geom_point(aes(fill = algorithm), shape = 21,size=1, position = position_dodge(0.9), color="black",alpha=0.3)+
  scale_fill_manual(values = c("#00AFBB", "#E7B800"))+
  theme(legend.position = "none") +
  blank_background

# Simple jitterplot
ggplot(global_data, aes(x = as.factor(real_period), y = estimated_period)) +
  geom_jitter(aes(color = algorithm), 
              position = position_jitterdodge(jitter.width = 0.2, dodge.width = 0.8),
              size = 1.2
  ) +
  stat_summary(aes(color = algorithm),
               fun.data="mean_sdl",  fun.args = list(mult=1), 
               geom = "pointrange",  size = 0.4,
               position = position_dodge(0.8))+
  scale_color_manual(values =  c("#00AFBB", "#E7B800")) +
  blank_background

# violin plot made of dots (ggforce)
ggplot(global_data, aes(x = as.factor(real_period), y = estimated_period)) +
  geom_sina(aes(color = algorithm), size = 0.9)+
  scale_color_manual(values =  c("#00AFBB", "#E7B800", "#FC4E07")) +
  blank_background