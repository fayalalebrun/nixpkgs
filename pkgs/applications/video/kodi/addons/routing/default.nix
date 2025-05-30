{
  lib,
  rel,
  buildKodiAddon,
  fetchzip,
  addonUpdateScript,
}:
buildKodiAddon rec {
  pname = "routing";
  namespace = "script.module.routing";
  version = "0.2.3+matrix.1";

  src = fetchzip {
    url = "https://mirrors.kodi.tv/addons/${lib.toLower rel}/${namespace}/${namespace}-${version}.zip";
    sha256 = "sha256-piPmY8Q3NyIeImmkYhDwmQhBiwwcV0X532xV1DogF+I=";
  };

  passthru = {
    pythonPath = "lib";
    updateScript = addonUpdateScript {
      attrPath = "kodi.packages.routing";
    };
  };

  meta = with lib; {
    homepage = "https://github.com/tamland/kodi-plugin-routing";
    description = "Routing module for kodi plugins";
    license = licenses.gpl3Plus;
    teams = [ teams.kodi ];
  };
}
