// Functions
// - Set of Top Part and Bottom Part
module lockHolderSet
(
	diameterTopTube = 30,
	lengthLock = 50,
	diameterLock = 15,
	nutSizeOuter = 10,
	nutSizeInner = 6,
	thickness = 5,
	offset = 2
)
{
	lengthTopTube = diameterLock + (2 * nutSizeOuter) + (3 * thickness);
	screwBarWidth = nutSizeOuter + (thickness / 2);

	translate(v = [(diameterTopTube / 2) + screwBarWidth + (1.5 * thickness), 0, 0]) {
		topPart(diameterTopTube, diameterLock, nutSizeOuter, nutSizeInner, thickness, offset);
	}

	translate(v = [(-1) * ((diameterTopTube / 2) + screwBarWidth + (1.5 * thickness)), 0, 0]) {
		rotate(a = [0, 0, 180]) {
			bottomPart(diameterTopTube, lengthLock, diameterLock, nutSizeOuter, nutSizeInner, thickness, offset);
		}
	}
}

// - Complete Set of 2 Top Parts and 2 Bottom Parts
module completeLockHolderSet
(
	diameterTopTube = 30,
	lengthLock = 50,
	diameterLock = 15,
	nutSizeOuter = 10,
	nutSizeInner = 6,
	thickness = 5,
	offset = 2
)
{
	lengthTopTube = diameterLock + (2 * nutSizeOuter) + (3 * thickness);
	screwBarWidth = nutSizeOuter + (thickness / 2);

	translate(v = [0, (lengthTopTube + thickness) / 2, 0]) {
		lockHolderSet(diameterTopTube, lengthLock, diameterLock, nutSizeOuter, nutSizeInner, thickness, offset);
	}

	translate(v = [0, (-1) * ((lengthTopTube + thickness) / 2), 0]) {
		lockHolderSet(diameterTopTube, lengthLock, diameterLock, nutSizeOuter, nutSizeInner, thickness, offset);
	}
}

// - Top Part
module topPart
(
	diameterTopTube = 30,
	diameterLock = 15,
	nutSizeOuter = 10,
	nutSizeInner = 6,
	thickness = 5,
	offset = 2
)
{
	lengthTopTube = diameterLock + (2 * nutSizeOuter) + (3 * thickness);
	screwBarWidth = nutSizeOuter + (thickness / 2);

	translate(v = [0, lengthTopTube / 2, 0]) {
		topPart1(lengthTopTube, diameterTopTube, diameterLock, screwBarWidth, nutSizeOuter, nutSizeInner, thickness, offset);
		translate(v = [0, (-1) * (nutSizeOuter + (thickness / 2)), 0]) {
			doubleStabilityBracing(diameterTopTube, screwBarWidth, thickness, offset);
		}
		translate(v = [0, (-1) * (lengthTopTube - (nutSizeOuter + (1.5 * thickness))), 0]) {
			doubleStabilityBracing(diameterTopTube, screwBarWidth, thickness, offset);
		}
	}
}

// - Bottom Part
module bottomPart
(
	diameterTopTube = 30,
	lengthLock = 50,
	diameterLock = 15,
	nutSizeOuter = 10,
	nutSizeInner = 6,
	thickness = 5,
	offset = 2
)
{
	lengthTopTube = diameterLock + (2 * nutSizeOuter) + (3 * thickness);
	screwBarWidth = nutSizeOuter + (thickness / 2);

	translate(v = [0, lengthTopTube / 2, 0]) {
		bottomPart1(lengthTopTube, diameterTopTube, lengthLock, diameterLock, screwBarWidth, nutSizeOuter, nutSizeInner, thickness, offset);
		translate(v = [0, (-1) * (nutSizeOuter + (thickness / 2)), 0]) {
			doubleStabilityBracing(diameterTopTube, screwBarWidth, thickness, offset);
		}
		translate(v = [0, (-1) * (lengthTopTube - (nutSizeOuter + (1.5 * thickness))), 0]) {
			doubleStabilityBracing(diameterTopTube, screwBarWidth, thickness, offset);
		}
		translate(v = [0, (-1) * ((lengthTopTube - thickness) / 2), 0]) {
			lockBracing(diameterTopTube, lengthLock, thickness, offset);
		}
	}
}

// Modules
module tube(height, diameter, thickness) {
	difference() {
		cylinder(h = height, r = ((diameter / 2) + thickness));
		translate(v = [0, 0, -1]) {
			cylinder(h = height + 2, r = diameter / 2);
		}
	}
}

module halfTube(height, diameter, thickness, offset) {
	difference() {
		tube(height, diameter, thickness);
		translate(v = [((-1) * (diameter + (2 * thickness))) / 2, (-1) * ((diameter / 2) + thickness) - 1, -1]) {
			cube([diameter + (2 * thickness), (diameter / 2) + thickness +1 + (offset / 2), height + 2]);
		}
	}
}

module screwBar(nutSizeOuter, lengthTopTube, diameterTopTube, thickness, offset) {
	difference() {
		hull() {
			translate(v = [((diameterTopTube + nutSizeOuter) / 2) + thickness, thickness + (offset / 2), (nutSizeOuter + thickness) / 2]) {
				rotate(a = [90, 0, 0]) {
					cylinder(r = ((nutSizeOuter + thickness) / 2), h = thickness);
				}
			}
			translate(v = [(-1) * (((diameterTopTube + nutSizeOuter) / 2) + thickness), thickness + (offset / 2), (nutSizeOuter + thickness) / 2]) {
				rotate(a = [90, 0, 0]) {
					cylinder(r = (nutSizeOuter + thickness) / 2, h = thickness);
				}
			}
			translate(v = [((diameterTopTube + nutSizeOuter) / 2) + thickness, thickness + (offset / 2), lengthTopTube - ((nutSizeOuter + thickness) / 2) ]) {
				rotate(a = [90, 0, 0]) {
					cylinder(r = ((nutSizeOuter + thickness) / 2), h = thickness);
				}
			}
			translate(v = [(-1) * (((diameterTopTube + nutSizeOuter) / 2) + thickness), thickness + (offset / 2), lengthTopTube - ((nutSizeOuter + thickness) / 2)]) {
				rotate(a = [90, 0, 0]) {
					cylinder(r = ((nutSizeOuter + thickness) / 2), h = thickness);
				}
			}
		}
		translate(v = [0, 0, -1]) {
			cylinder(r = diameterTopTube / 2, h = lengthTopTube + 2);
		}
	}
}

module tubeWithBar(lengthTopTube, diameterTopTube, nutSizeOuter, thickness, offset) {
	union() {
		halfTube(lengthTopTube, diameterTopTube, thickness, offset);
		screwBar(nutSizeOuter, lengthTopTube, diameterTopTube, thickness, offset);
	}
}

module makeNut(diameter, thickness) {
	translate(v = [0, 2 * (thickness / 3), 0]) {
		rotate(a = [90, 0, 0]) {
			translate(v = [0, 0, (-1) * (thickness / 2)]) {
				hexagon(size = diameter, height = thickness);
			}
		}
	}
}

module screwHeadHole(diameter, thickness) {
	translate(v = [0, 2 * (thickness / 3), 0]) {
		rotate(a = [-90, 0, 0]) {
			cylinder(r = diameter / 2, h = thickness);
		}
	}
}

module screwHole(diameter, thickness) {
	translate(v = [0, -1, 0]) {
		rotate(a = [-90, 0, 0]) {
			cylinder(r = diameter / 2, h = thickness + 2);
		}
	}
}

module positionNuts(diameter, plateSizeX, plateSizeY, thickness) {
	translate(v = [(plateSizeX + diameter) / 2, 0, ((diameter + thickness) / 2)]) {
		makeNut(diameter, thickness);
	}
	translate(v = [(plateSizeX + diameter) / 2, 0, plateSizeY - ((diameter + thickness) / 2)]) {
		makeNut(diameter, thickness);
	}
	translate(v = [(-1) * ((plateSizeX + diameter) / 2), 0, ((diameter + thickness) / 2)]) {
		makeNut(diameter, thickness);
	}
	translate(v = [(-1) * ((plateSizeX + diameter) / 2), 0, plateSizeY - ((diameter + thickness) / 2)]) {
		makeNut(diameter, thickness);
	}
}

module positionScrewHeadHoles(diameter, plateSizeX, plateSizeY, thickness) {
	translate(v = [(plateSizeX + diameter) / 2, 0, ((diameter + thickness) / 2)]) {
		screwHeadHole(diameter, thickness);
	}
	translate(v = [(plateSizeX + diameter) / 2, 0, plateSizeY - ((diameter + thickness) / 2)]) {
		screwHeadHole(diameter, thickness);
	}
	translate(v = [(-1) * ((plateSizeX + diameter) / 2), 0, ((diameter + thickness) / 2)]) {
		screwHeadHole(diameter, thickness);
	}
	translate(v = [(-1) * ((plateSizeX + diameter) / 2), 0, plateSizeY - ((diameter + thickness) / 2)]) {
		screwHeadHole(diameter, thickness);
	}
}

module positionScrewHoles(diameterInner, diameterOuter, plateSizeX, plateSizeY, thickness) {
	translate(v = [(plateSizeX + diameterOuter) / 2, 0, ((diameterOuter + thickness) / 2)]) {
		screwHole(diameterInner, thickness);
	}
	translate(v = [(plateSizeX + diameterOuter) / 2, 0, plateSizeY - ((diameterOuter + thickness) / 2)]) {
		screwHole(diameterInner, thickness);
	}
	translate(v = [(-1) * ((plateSizeX + diameterOuter) / 2), 0, ((diameterOuter + thickness) / 2)]) {
		screwHole(diameterInner, thickness);
	}
	translate(v = [(-1) * ((plateSizeX + diameterOuter) / 2), 0, plateSizeY - ((diameterOuter + thickness) / 2)]) {
		screwHole(diameterInner, thickness);
	}
}

module nutHolesComplete(diameterOuter, diameterInner, plateSizeX, plateSizeY, thickness, offset) {
	translate(v = [0, offset / 2, 0]) {
		union() {
			positionNuts(diameterOuter, plateSizeX, plateSizeY, thickness);
			positionScrewHoles(diameterInner, diameterOuter, plateSizeX, plateSizeY, thickness);
		}
	}
}

module screwHeadHolesComplete(diameterOuter, diameterInner, plateSizeX, plateSizeY, thickness, offset) {
	translate(v = [0, offset / 2, 0]) {
		union() {
			positionScrewHeadHoles(diameterOuter, plateSizeX, plateSizeY, thickness);
			positionScrewHoles(diameterInner, diameterOuter, plateSizeX, plateSizeY, thickness);
		}
	}
}

module topPart1(lengthTopTube, diameterTopTube, diameterLock, screwBarWidth, nutSizeOuter, nutSizeInner, thickness, offset) {
translate(v = [0, 0, (-1) * (offset / 2)]) {
		rotate(a = [90, 0, 0]) {
			difference() {
				difference() {
					tubeWithBar(lengthTopTube, diameterTopTube, nutSizeOuter, thickness, offset);
					screwHeadHolesComplete(nutSizeOuter, nutSizeInner, diameterTopTube + (2 * thickness), lengthTopTube, thickness, offset);
				}
	// -- Hole for Lock Tube
				translate(v = [((diameterTopTube + diameterLock) / 2) + thickness, thickness + (offset / 2) + 1, lengthTopTube / 2]) {
					rotate(a = [90, 0, 0]) {
						union() {
							cylinder(r = diameterLock / 2, h = thickness + 2);
							translate(v = [diameterLock / 2, 0, (thickness / 2) + 1]) {
								cube([diameterLock, diameterLock, thickness + 2], true);
							}
						}
					}
				}
			}
		}
	}
}

module bottomPart1(lengthTopTube, diameterTopTube, lengthLock, diameterLock, screwBarWidth, nutSizeOuter, nutSizeInner, thickness, offset) {
	translate(v = [0, 0, (-1) * (offset / 2)]) {
		rotate(a = [90, 0, 0]) {
			difference() {
				union() {
					difference() {
						tubeWithBar(lengthTopTube, diameterTopTube, nutSizeOuter, thickness, offset);
						nutHolesComplete(nutSizeOuter, nutSizeInner, diameterTopTube + (2 * thickness), lengthTopTube, thickness, offset);
					}
	// -- Lock Tube
					translate(v = [((diameterTopTube + diameterLock) / 2) + thickness, lengthLock + (offset / 2), lengthTopTube / 2]) {
						rotate(a = [90, 0, 0]) {
							tube(lengthLock, diameterLock, thickness);
						}
					}
				}
	// -- Hole for Lock Tube
				translate(v = [((diameterTopTube + diameterLock) / 2) + thickness, lengthLock + 1 + (offset / 2), lengthTopTube / 2]) {
						rotate(a = [90, 0, 0]) {
							cylinder(r = diameterLock / 2, h = lengthLock + 2);
						}
				}
			}
		}
	}
}

module stabilityBracing(diameterTopTube, screwBarWidth, thickness, offset) {
	rotate(a = [90, 0, 0]) {
		difference() {
			linear_extrude(height = thickness) {
					polygon(points = [[0, thickness], [(diameterTopTube / 2) + screwBarWidth + thickness, thickness], [0, ((diameterTopTube - offset) / 2) + thickness]], paths = [[0, 1, 2]]);
			}
			translate(v = [0, (-1) * (offset / 2), -1]) {
				cylinder(r = diameterTopTube / 2, h = thickness + 2);
			}
		}
	}
}

module doubleStabilityBracing(diameterTopTube, screwBarWidth, thickness, offset) {
	stabilityBracing(diameterTopTube, screwBarWidth, thickness, offset);
	rotate(a = [0, 0, 180]) {
		translate(v = [0, thickness, 0]) {
			stabilityBracing(diameterTopTube, screwBarWidth, thickness, offset);
		}
	}
}

module lockBracing(diameterTopTube, lengthLock, thickness, offset) {
	rotate(a = [90, 0, 0]) {
		difference() {
			linear_extrude(height = thickness) {
				polygon(points = [[0, 0], [(diameterTopTube / 2) + thickness, 0], [(diameterTopTube / 2) + thickness, lengthLock], [0, ((diameterTopTube - offset) / 2) + thickness]], paths = [[0, 1, 2, 3]]);
			}
			translate(v = [0, (-1) * (offset / 2), -1]) {
				cylinder(r = diameterTopTube / 2, h = thickness + 2);
			}
		}
	}
}

module hexagon(size, height) {
	// http://svn.clifford.at/openscad/trunk/libraries/shapes.scad
	/*
	 *  OpenSCAD Shapes Library (www.openscad.org)
	 *  Copyright (C) 2009  Catarina Mota
	 *
	 *  This program is free software; you can redistribute it and/or modify
	 *  it under the terms of the GNU General Public License as published by
	 *  the Free Software Foundation; either version 2 of the License, or
	 *  (at your option) any later version.
	 *
	 *  This program is distributed in the hope that it will be useful,
	 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
	 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	 *  GNU General Public License for more details.
	 *
	 *  You should have received a copy of the GNU General Public License
	 *  along with this program; if not, write to the Free Software
	 *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
	 *
	*/
	boxWidth = size/1.75;
	for (r = [-60, 0, 60]) rotate([0,0,r]) cube([boxWidth, size, height], true);
}
