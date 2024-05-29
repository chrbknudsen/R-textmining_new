library(tidyverse)
library(readr)
library(guardianapi)
# kør og giv den api-nøglen i console
guardianapi::gu_api_key()



obama <- guardianapi::gu_content(query = "Obama", from_date = "2009-01-20", to_date = "2009-01-20")


obama %>% 
  filter(!(type %in% c("gallery", "audio", "video"))) %>%
  filter(!(section_id %in% c("tv-and-radio", 
                             "film", 
                             "football", 
                             "stage", 
                             "theguardian",
                             "lifeandstyle", 
                             "sport",
                             "media",
                             "travel",
                             "music"))) %>% 
    select(-c(type, section_name, web_url, api_url, 
              tags, is_hosted, pillar_id, main, wordcount, 
              production_office, is_premoderated, 
              last_modified:show_in_related_content,
              thumbnail:is_live, char_count:comment_close_date,
              section_id, web_title, trail_text, body
              )) %>% 
  mutate(id = row_number()) %>%
  write_csv("episodes/data/obama.csv")  
