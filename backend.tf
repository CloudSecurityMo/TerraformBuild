terraform { 
  cloud { 
    
    organization = "shoddy" 

    workspaces { 
      name = "TerraformBuild" 
    } 
  } 
}