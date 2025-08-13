library("tidyverse")
data_aquired = as.Date("2025-08-13")
fac = 365 / as.numeric(as.Date("2025-08-13") - as.Date("2024-12-31")) # for extrapolation 2025

b = readr::read_csv("B-PubMed_Timeline_Results_by_Year.csv", skip = 1) # https://pubmed.ncbi.nlm.nih.gov/?term=%22B+cell%22+AND+cancer&sort=pubdate
t = readr::read_csv("T-PubMed_Timeline_Results_by_Year.csv", skip = 1) # https://pubmed.ncbi.nlm.nih.gov/?term=%22T+cell%22+AND+cancer&sort=pubdate
x = bind_rows(mutate(b, type = "B"), mutate(t, type = "T"))
x = mutate(x, Count = ifelse(Year == 2025, fac*Count, Count)) |>
  filter(Year >= 1972 & Year <= 2025)

gg = ggplot(x, aes(x = Year, y = Count, col = type)) + geom_line() + geom_point(size = 0.5) +
  scale_color_manual(values = c(T = "darkorange", B = "turquoise")) +
  ylab("Entries / year in Pubmed")  # + scale_y_log10()

ggsave("B-vs-T-pubmed.png", gg, width = 6, height = 4, dpi = 300)     
ggsave("B-vs-T-pubmed.pdf", gg, width = 6, height = 4, dpi = 300)     