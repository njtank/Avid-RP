fx_version 'cerulean'
game 'gta5'

author 'G&N Studio'
description 'Scenarios Modification - Davis Sheriff Dept'
version '1.0.0'

files {
    'sp_manifest.ymt',
}

dependencies {
    '/server:4960',
    '/gameBuild:2189'
}

data_file 'SCENARIO_POINTS_OVERRIDE_PSO_FILE' 'sp_manifest.ymt'

escrow_ignore {
    'sp_manifest.ymt',
    'stream/*.ymt',
  }
dependency '/assetpacks'