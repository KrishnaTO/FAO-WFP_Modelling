rhdx::set_rhdx_config(hdx_site = "prod")
wfp <- rhdx::pull_dataset("wfp-food-prices") %>% 
  rhdx::get_resource(index = 1) %>% 
  rhdx::read_resource(wfp, folder = getwd())
readr::write_rds(wfp, paste(getwd(), "/WFP/wfp.rds", sep = ""))