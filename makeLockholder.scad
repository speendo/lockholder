// Resolution
$fn=200;

// Imports
include <lockholder.scad>;

lockHolderSet
(
	diameterTopTube = 31.75+0.5,
// Diameter of your bike's top tube (or any other tube on which you want to mount the lockholder)

	lengthLock = 50,
// The length of the tube where you put the lock through. The longer the less vibrations while riding. On the other hand, if the the tube gets too long it might be clumsy

	diameterLock = 19+1,
// Diameter of the lock (this will be the inner diameter of the part that holds the lock)

	nutSizeOuter = 8+1,
// The outer diameter of your hexagonal screw nut A/F in the picture here (http://en.wikipedia.org/wiki/Nut_%28hardware%29#Standard_metric_hex_nuts_sizes)

	nutSizeInner = 4.55+1,
// Diameter of your screw thread

	thickness = 4,
// Material thickness

	offset = 0,
// Offset between upper and lower part of the lockholder. The bigger this value is, the tighter you can screw the lockholder on your bike. However, if offset is getting too big, the material might break while fastening the screw. Normally the lockholders arc would bend down a bit anyway while printing. In this case you can relax and set this value to zero. Otherwise you might want to set it to 1 or 2 mm. If you don't understand the purpose of this variable, try setting it to a large fraction of diameterTopTube and check the result - then you will probably understand it.

	screwOffsetShare = 0.75
// This value allows to master the thickness of the screwholes as a schare of <thickness>. At 1, there is no difference to normal thickness, at 0 there is no material to fix the screw. To be on the save side this should be 1 or not to much lower.
);

