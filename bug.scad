lockHolderSet
(
	diameterTopTube = 30,
	lengthLock = 50,
	diameterLock = 15,
	nutSizeOuter = 10,
	nutSizeInner = 6,
	thickness = 5,
	offset = 2,
	screwOffsetShare = 0
);

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
	offset = 2,
	screwOffsetShare = 0.75
)
{
	lengthTopTube = diameterLock + (2 * nutSizeOuter) + (3 * thickness);
	screwBarWidth = nutSizeOuter + (thickness / 2);

	translate(v = [(diameterTopTube / 2) + screwBarWidth + (1.5 * thickness), 0, 0]) {
		topPart(diameterTopTube, diameterLock, nutSizeOuter, nutSizeInner, thickness, offset, screwOffsetShare);
	}

	translate(v = [(-1) * ((diameterTopTube / 2) + screwBarWidth + (1.5 * thickness)), 0, 0]) {
		rotate(a = [0, 0, 180]) {
			bottomPart(diameterTopTube, lengthLock, diameterLock, nutSizeOuter, nutSizeInner, thickness, offset, screwOffsetShare);
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
	offset = 2,
	screwOffsetShare = 0.75
)
{
	lengthTopTube = diameterLock + (2 * nutSizeOuter) + (3 * thickness);
	screwBarWidth = nutSizeOuter + (thickness / 2);

	translate(v = [0, (lengthTopTube + thickness) / 2, 0]) {
		lockHolderSet(diameterTopTube, lengthLock, diameterLock, nutSizeOuter, nutSizeInner, thickness, offset, screwOffsetShare);
	}

	translate(v = [0, (-1) * ((lengthTopTube + thickness) / 2), 0]) {
		lockHolderSet(diameterTopTube, lengthLock, diameterLock, nutSizeOuter, nutSizeInner, thickness, offset, screwOffsetShare);
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
	offset = 2,
	screwOffsetShare = 0.75
)
{
	lengthTopTube = diameterLock + (2 * nutSizeOuter) + (3 * thickness);
	screwBarWidth = nutSizeOuter + (thickness / 2);

	translate(v = [0, lengthTopTube / 2, 0]) {
		topPart1(lengthTopTube, diameterTopTube, diameterLock, screwBarWidth, nutSizeOuter, nutSizeInner, thickness, offset, screwOffsetShare);
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
	offset = 2,
	screwOffsetShare = 0.75
)
{
	lengthTopTube = diameterLock + (2 * nutSizeOuter) + (3 * thickness);
	screwBarWidth = nutSizeOuter + (thickness / 2);

	translate(v = [0, lengthTopTube / 2, 0]) {
		bottomPart1(lengthTopTube, diameterTopTube, lengthLock, diameterLock, screwBarWidth, nutSizeOuter, nutSizeInner, thickness, offset, screwOffsetShare);
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

module screwBar(nutSizeOuter, lengthTopTube, diameterTopTube, thickness, offset, screwOffsetShare) {
		union() {
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
//			positionShells(nutSizeOuter, diameterTopTube + (2 * thickness), lengthTopTube, thickness, offset, screwOffsetShare);
// add again later
		}
}

module tubeWithBar(lengthTopTube, diameterTopTube, nutSizeOuter, thickness, offset, screwOffsetShare) {
	screwBar(nutSizeOuter, lengthTopTube, diameterTopTube, thickness, offset, screwOffsetShare);
}

module makeShell(diameter, thickness, offset, screwOffsetShare) {
	translate(v = [0, ((1 + screwOffsetShare) * thickness) + (offset / 2), 0]) {
		rotate(a = [90, 0, 0]) {
			cylinder(r = (diameter + thickness) / 2, h = thickness);
		}
	}
}

module makeNut(diameter, thickness, screwOffsetShare) {
	translate(v = [0, (screwOffsetShare * thickness) + 1, 0]) {
		rotate(a = [90, 0, 0]) {
			translate(v = [0, 0, (-1) * (thickness / 2)]) {
				hexagon(size = diameter, height = thickness + 2);
			}
		}
	}
}

module screwHeadHole(diameter, thickness, screwOffsetShare) {
	translate(v = [0, (screwOffsetShare * thickness), 0]) {
		rotate(a = [-90, 0, 0]) {
			cylinder(r = diameter / 2, h = thickness + 2);
		}
	}
}

module screwHole(diameter, thickness) {
	translate(v = [0, -1, 0]) {
		rotate(a = [-90, 0, 0]) {
			cylinder(r = diameter / 2, h = (2 * thickness) + 2);
		}
	}
}

module positionShells(diameter, plateSizeX, plateSizeY, thickness, offset, screwOffsetShare) {
	translate(v = [(plateSizeX + diameter) / 2, 0, ((diameter + thickness) / 2)]) {
		makeShell(diameter, thickness, offset, screwOffsetShare);
	}
	translate(v = [(plateSizeX + diameter) / 2, 0, plateSizeY - ((diameter + thickness) / 2)]) {
		makeShell(diameter, thickness, offset, screwOffsetShare);
	}
	translate(v = [(-1) * ((plateSizeX + diameter) / 2), 0, ((diameter + thickness) / 2)]) {
		makeShell(diameter, thickness, offset, screwOffsetShare);
	}
	translate(v = [(-1) * ((plateSizeX + diameter) / 2), 0, plateSizeY - ((diameter + thickness) / 2)]) {
		makeShell(diameter, thickness, offset, screwOffsetShare);
	}
}

module positionNuts(diameter, plateSizeX, plateSizeY, thickness, screwOffsetShare) {
	translate(v = [(plateSizeX + diameter) / 2, 0, ((diameter + thickness) / 2)]) {
		makeNut(diameter, thickness, screwOffsetShare);
	}
	translate(v = [(plateSizeX + diameter) / 2, 0, plateSizeY - ((diameter + thickness) / 2)]) {
		makeNut(diameter, thickness, screwOffsetShare);
	}
	translate(v = [(-1) * ((plateSizeX + diameter) / 2), 0, ((diameter + thickness) / 2)]) {
		makeNut(diameter, thickness, screwOffsetShare);
	}
	translate(v = [(-1) * ((plateSizeX + diameter) / 2), 0, plateSizeY - ((diameter + thickness) / 2)]) {
		makeNut(diameter, thickness, screwOffsetShare);
	}
}

module positionScrewHeadHoles(diameter, plateSizeX, plateSizeY, thickness, screwOffsetShare) {
	translate(v = [(plateSizeX + diameter) / 2, 0, ((diameter + thickness) / 2)]) {
		screwHeadHole(diameter, thickness, screwOffsetShare);
	}
	translate(v = [(plateSizeX + diameter) / 2, 0, plateSizeY - ((diameter + thickness) / 2)]) {
		screwHeadHole(diameter, thickness, screwOffsetShare);
	}
	translate(v = [(-1) * ((plateSizeX + diameter) / 2), 0, ((diameter + thickness) / 2)]) {
		screwHeadHole(diameter, thickness, screwOffsetShare);
	}
	translate(v = [(-1) * ((plateSizeX + diameter) / 2), 0, plateSizeY - ((diameter + thickness) / 2)]) {
		screwHeadHole(diameter, thickness, screwOffsetShare);
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

module nutHolesComplete(diameterOuter, diameterInner, plateSizeX, plateSizeY, thickness, offset, screwOffsetShare) {
	translate(v = [0, offset / 2, 0]) {
		union() {
			positionNuts(diameterOuter, plateSizeX, plateSizeY, thickness, screwOffsetShare);
			positionScrewHoles(diameterInner, diameterOuter, plateSizeX, plateSizeY, thickness);
		}
	}
}

module screwHeadHolesComplete(diameterOuter, diameterInner, plateSizeX, plateSizeY, thickness, offset, screwOffsetShare) {
	translate(v = [0, offset / 2, 0]) {
		union() {
			positionScrewHeadHoles(diameterOuter, plateSizeX, plateSizeY, thickness, screwOffsetShare);
			positionScrewHoles(diameterInner, diameterOuter, plateSizeX, plateSizeY, thickness);
		}
	}
}

module topPart1(lengthTopTube, diameterTopTube, diameterLock, screwBarWidth, nutSizeOuter, nutSizeInner, thickness, offset, screwOffsetShare) {
translate(v = [0, 0, (-1) * (offset / 2)]) {
		rotate(a = [90, 0, 0]) {
				difference() {
					tubeWithBar(lengthTopTube, diameterTopTube, nutSizeOuter, thickness, offset, screwOffsetShare);
#					screwHeadHolesComplete(nutSizeOuter, nutSizeInner, diameterTopTube + (2 * thickness), lengthTopTube, thickness, offset, screwOffsetShare);
				}
			}
	}
}

module bottomPart1(lengthTopTube, diameterTopTube, lengthLock, diameterLock, screwBarWidth, nutSizeOuter, nutSizeInner, thickness, offset, screwOffsetShare) {
	translate(v = [0, 0, (-1) * (offset / 2)]) {
		rotate(a = [90, 0, 0]) {
					difference() {
						tubeWithBar(lengthTopTube, diameterTopTube, nutSizeOuter, thickness, offset, screwOffsetShare);
#						nutHolesComplete(nutSizeOuter, nutSizeInner, diameterTopTube + (2 * thickness), lengthTopTube, thickness, offset, screwOffsetShare);
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
