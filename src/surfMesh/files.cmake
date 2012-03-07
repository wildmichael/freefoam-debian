#-------------------------------------------------------------------------------
#               ______                _     ____          __  __
#              |  ____|             _| |_  / __ \   /\   |  \/  |
#              | |__ _ __ ___  ___ /     \| |  | | /  \  | \  / |
#              |  __| '__/ _ \/ _ ( (| |) ) |  | |/ /\ \ | |\/| |
#              | |  | | |  __/  __/\_   _/| |__| / ____ \| |  | |
#              |_|  |_|  \___|\___|  |_|   \____/_/    \_\_|  |_|
#
#                   FreeFOAM: The Cross-Platform CFD Toolkit
#
# Copyright (C) 2008-2012 Michael Wild <themiwi@users.sf.net>
#                         Gerber van der Graaf <gerber_graaf@users.sf.net>
#-------------------------------------------------------------------------------
# License
#   This file is part of FreeFOAM.
#
#   FreeFOAM is free software: you can redistribute it and/or modify it
#   under the terms of the GNU General Public License as published by the
#   Free Software Foundation, either version 3 of the License, or (at your
#   option) any later version.
#
#   FreeFOAM is distributed in the hope that it will be useful, but WITHOUT
#   ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
#   FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
#   for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with FreeFOAM.  If not, see <http://www.gnu.org/licenses/>.
#-------------------------------------------------------------------------------

set(SRCS
  surfZone/surfZone/surfZone.C
  surfZone/surfZone/surfZoneIOList.C
  surfZone/surfZoneIdentifier/surfZoneIdentifier.C
  MeshedSurfaceAllocator/MeshedSurfaceIOAllocator.C
  MeshedSurface/MeshedSurfaceCore.C
  MeshedSurface/MeshedSurfaces.C
  UnsortedMeshedSurface/UnsortedMeshedSurfaces.C
  MeshedSurfaceProxy/MeshedSurfaceProxyCore.C
  surfaceRegistry/surfaceRegistry.C
  surfMesh/surfMesh.C
  surfMesh/surfMeshClear.C
  surfMesh/surfMeshIO.C
  surfFields/surfFields/surfFields.C
  surfFields/surfPointFields/surfPointFields.C
  surfaceFormats/surfaceFormatsCore.C
  surfaceFormats/ac3d/AC3DsurfaceFormatCore.C
  surfaceFormats/ac3d/AC3DsurfaceFormatRunTime.C
  surfaceFormats/ftr/FTRsurfaceFormatRunTime.C
  surfaceFormats/gts/GTSsurfaceFormatRunTime.C
  surfaceFormats/nas/NASsurfaceFormatCore.C
  surfaceFormats/nas/NASsurfaceFormatRunTime.C
  surfaceFormats/obj/OBJsurfaceFormatRunTime.C
  surfaceFormats/off/OFFsurfaceFormatRunTime.C
  surfaceFormats/ofs/OFSsurfaceFormatCore.C
  surfaceFormats/ofs/OFSsurfaceFormatRunTime.C
  surfaceFormats/smesh/SMESHsurfaceFormatRunTime.C
  surfaceFormats/starcd/STARCDsurfaceFormatCore.C
  surfaceFormats/starcd/STARCDsurfaceFormatRunTime.C
  surfaceFormats/stl/STLsurfaceFormatCore.C
  surfaceFormats/stl/STLsurfaceFormatRunTime.C
  surfaceFormats/stl/STLsurfaceFormatASCII.L
  surfaceFormats/tri/TRIsurfaceFormatCore.C
  surfaceFormats/tri/TRIsurfaceFormatRunTime.C
  surfaceFormats/vtk/VTKsurfaceFormatCore.C
  surfaceFormats/vtk/VTKsurfaceFormatRunTime.C
  surfaceFormats/wrl/WRLsurfaceFormatCore.C
  surfaceFormats/wrl/WRLsurfaceFormatRunTime.C
  surfaceFormats/x3d/X3DsurfaceFormatCore.C
  surfaceFormats/x3d/X3DsurfaceFormatRunTime.C
  )

set(HDRS
  MeshedSurface/MeshedSurface.C
  MeshedSurface/MeshedSurface.H
  MeshedSurface/MeshedSurfaceIO.C
  MeshedSurface/MeshedSurfaceNew.C
  MeshedSurface/MeshedSurfaceZones.C
  MeshedSurface/MeshedSurfaces.H
  MeshedSurface/MeshedSurfacesFwd.H
  MeshedSurfaceAllocator/MeshedSurfaceIOAllocator.H
  MeshedSurfaceProxy/MeshedSurfaceProxy.C
  MeshedSurfaceProxy/MeshedSurfaceProxy.H
  UnsortedMeshedSurface/UnsortedMeshedSurface.C
  UnsortedMeshedSurface/UnsortedMeshedSurface.H
  UnsortedMeshedSurface/UnsortedMeshedSurfaceNew.C
  UnsortedMeshedSurface/UnsortedMeshedSurfaces.H
  UnsortedMeshedSurface/UnsortedMeshedSurfacesFwd.H
  surfFields/surfFields/surfFields.H
  surfFields/surfFields/surfFieldsFwd.H
  surfFields/surfFields/surfGeoMesh.H
  surfFields/surfPointFields/surfPointFields.H
  surfFields/surfPointFields/surfPointFieldsFwd.H
  surfFields/surfPointFields/surfPointGeoMesh.H
  surfMesh/surfMesh.H
  surfZone/surfZone/surfZone.H
  surfZone/surfZone/surfZoneIOList.H
  surfZone/surfZone/surfZoneList.H
  surfZone/surfZoneIdentifier/surfZoneIdentifier.H
  surfZone/surfZoneIdentifier/surfZoneIdentifierList.H
  surfaceFormats/ac3d/AC3DsurfaceFormat.C
  surfaceFormats/ac3d/AC3DsurfaceFormat.H
  surfaceFormats/ac3d/AC3DsurfaceFormatCore.H
  surfaceFormats/ac3d/AC3DsurfaceFormatCoreTemplates.C
  surfaceFormats/ftr/FTRsurfaceFormat.C
  surfaceFormats/ftr/FTRsurfaceFormat.H
  surfaceFormats/gts/GTSsurfaceFormat.C
  surfaceFormats/gts/GTSsurfaceFormat.H
  surfaceFormats/nas/NASsurfaceFormat.C
  surfaceFormats/nas/NASsurfaceFormat.H
  surfaceFormats/nas/NASsurfaceFormatCore.H
  surfaceFormats/obj/OBJsurfaceFormat.C
  surfaceFormats/obj/OBJsurfaceFormat.H
  surfaceFormats/off/OFFsurfaceFormat.C
  surfaceFormats/off/OFFsurfaceFormat.H
  surfaceFormats/ofs/OFSsurfaceFormat.C
  surfaceFormats/ofs/OFSsurfaceFormat.H
  surfaceFormats/ofs/OFSsurfaceFormatCore.H
  surfaceFormats/smesh/SMESHsurfaceFormat.C
  surfaceFormats/smesh/SMESHsurfaceFormat.H
  surfaceFormats/starcd/STARCDsurfaceFormat.C
  surfaceFormats/starcd/STARCDsurfaceFormat.H
  surfaceFormats/starcd/STARCDsurfaceFormatCore.H
  surfaceFormats/stl/STLpoint.H
  surfaceFormats/stl/STLsurfaceFormat.C
  surfaceFormats/stl/STLsurfaceFormat.H
  surfaceFormats/stl/STLsurfaceFormatCore.H
  surfaceFormats/stl/STLtriangle.H
  surfaceFormats/stl/STLtriangleI.H
  surfaceFormats/surfaceFormatsCore.H
  surfaceFormats/tri/TRIsurfaceFormat.C
  surfaceFormats/tri/TRIsurfaceFormat.H
  surfaceFormats/tri/TRIsurfaceFormatCore.H
  surfaceFormats/vtk/VTKsurfaceFormat.C
  surfaceFormats/vtk/VTKsurfaceFormat.H
  surfaceFormats/vtk/VTKsurfaceFormatCore.H
  surfaceFormats/wrl/WRLsurfaceFormat.C
  surfaceFormats/wrl/WRLsurfaceFormat.H
  surfaceFormats/wrl/WRLsurfaceFormatCore.H
  surfaceFormats/x3d/X3DsurfaceFormat.C
  surfaceFormats/x3d/X3DsurfaceFormat.H
  surfaceFormats/x3d/X3DsurfaceFormatCore.H
  surfaceRegistry/surfaceRegistry.H
  )

# ------------------------- vim: set sw=2 sts=2 et: --------------- end-of-file
