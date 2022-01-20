//AMAZON & CERRADO raster identifying main LU and soy-deforestation  2001-2018

var trans_a = ee.Image('projects/mapbiomas-workspace/public/collection5/mapbiomas_collection50_transitions_v1') // used for deforestation
var MapBiomas = ee.Image ('projects/mapbiomas-workspace/public/collection5/mapbiomas_collection50_integration_v1')

print(trans_a)
print (trans_a.projection().nominalScale())
print (trans_a.projection())
//load municipalities of Brazil from private assets
//var shape = ee.FeatureCollection('users/floriangollnow/AdminBr/BRMUE250GC_WGS84')
var bla = ee.FeatureCollection("users/floriangollnow/AdminBr/limite_cerrado_wgs84");
var ama = ee.FeatureCollection("users/floriangollnow/BIOMES/Brazil_Amazon")
var cerr = ee.FeatureCollection("users/floriangollnow/BIOMES/Brazil_Cerrado")
//identify soy in Mapbiomas 
//identify forest (use 2000 as forest base)


var Mapb_f2000 = trans_a.select('transition_2000_2001')
var Mapb_fa_2000 = Mapb_f2000.gt(299).and(Mapb_f2000.lt(600))//identifies forest in 2000
//Map.addLayer(Mapb_fa_2000,{}, "forest2000")

var Mapb_c_2001 = Mapb_f2000.eq(339).or(Mapb_f2000.eq(439)).or(Mapb_f2000.eq(539)).or(Mapb_f2000.eq(939)).or(Mapb_f2000.eq(1139)).
or(Mapb_f2000.eq(239)).or(Mapb_f2000.eq(3239)).or(Mapb_f2000.eq(2939)).or(Mapb_f2000.eq(1339)).or(Mapb_f2000.eq(1539)).or(Mapb_f2000.eq(2039)).
or(Mapb_f2000.eq(4139)).or(Mapb_f2000.eq(4639)).or(Mapb_f2000.eq(2139)).or(Mapb_f2000.eq(2339)).or(Mapb_f2000.eq(2439)).or(Mapb_f2000.eq(3039)).
or(Mapb_f2000.eq(2539)).or(Mapb_f2000.eq(3339)).or(Mapb_f2000.eq(2739)).or(Mapb_f2000.eq(39))
//Map.addLayer(Mapb_c_2001,{}, "conv4Soy")

var Mapb_f2001 = trans_a.select('transition_2001_2002')
var Mapb_fa_2001 =  Mapb_fa_2000.eq(1).and(Mapb_f2001.gt(299).and(Mapb_f2001.lt(600)))//identifies forest in 2001 that was also forest in 2000

var Mapb_c_2002 = Mapb_f2001.eq(339).or(Mapb_f2001.eq(439)).or(Mapb_f2001.eq(539)).or(Mapb_f2001.eq(939)).or(Mapb_f2001.eq(1139)).
or(Mapb_f2001.eq(239)).or(Mapb_f2001.eq(3239)).or(Mapb_f2001.eq(2939)).or(Mapb_f2001.eq(1339)).or(Mapb_f2001.eq(1539)).
or(Mapb_f2001.eq(2039)).or(Mapb_f2001.eq(4139)).or(Mapb_f2001.eq(4639)).or(Mapb_f2001.eq(2139)).or(Mapb_f2001.eq(2339)).or(Mapb_f2001.eq(2439)).
or(Mapb_f2001.eq(3039)).or(Mapb_f2001.eq(2539)).or(Mapb_f2001.eq(3339)).or(Mapb_f2001.eq(2739)).or(Mapb_f2001.eq(39))

var Mapb_f2002 = trans_a.select('transition_2002_2003')
var Mapb_fa_2002 =  Mapb_fa_2001.eq(1).and(Mapb_f2002.gt(299).and(Mapb_f2002.lt(600)))

var Mapb_c_2003 = Mapb_f2002.eq(339).or(Mapb_f2002.eq(439)).or(Mapb_f2002.eq(539)).or(Mapb_f2002.eq(939)).or(Mapb_f2002.eq(1139)).
or(Mapb_f2002.eq(239)).or(Mapb_f2002.eq(3239)).or(Mapb_f2002.eq(2939)).or(Mapb_f2002.eq(1339)).or(Mapb_f2002.eq(1539)).
or(Mapb_f2002.eq(2039)).or(Mapb_f2002.eq(4139)).or(Mapb_f2002.eq(4639)).or(Mapb_f2002.eq(2139)).or(Mapb_f2002.eq(2339)).or(Mapb_f2002.eq(2439)).
or(Mapb_f2002.eq(3039)).or(Mapb_f2002.eq(2539)).or(Mapb_f2002.eq(3339)).or(Mapb_f2002.eq(2739)).or(Mapb_f2002.eq(39))

var Mapb_f2003 = trans_a.select('transition_2003_2004')
var Mapb_fa_2003 =  Mapb_fa_2002.eq(1).and(Mapb_f2003.gt(299).and(Mapb_f2003.lt(600)))


var Mapb_c_2004 = Mapb_f2003.eq(339).or(Mapb_f2003.eq(439)).or(Mapb_f2003.eq(539)).or(Mapb_f2003.eq(939)).or(Mapb_f2003.eq(1139)).
or(Mapb_f2003.eq(239)).or(Mapb_f2003.eq(3239)).or(Mapb_f2003.eq(2939)).or(Mapb_f2003.eq(1339)).or(Mapb_f2003.eq(1539)).
or(Mapb_f2003.eq(2039)).or(Mapb_f2003.eq(4139)).or(Mapb_f2003.eq(4639)).or(Mapb_f2003.eq(2139)).or(Mapb_f2003.eq(2339)).or(Mapb_f2003.eq(2439)).
or(Mapb_f2003.eq(3039)).or(Mapb_f2003.eq(2539)).or(Mapb_f2003.eq(3339)).or(Mapb_f2003.eq(2739)).or(Mapb_f2003.eq(39))

var Mapb_f2004 = trans_a.select('transition_2004_2005')
var Mapb_fa_2004 =  Mapb_fa_2003.eq(1).and(Mapb_f2004.gt(299).and(Mapb_f2004.lt(600)))


var Mapb_c_2005 = Mapb_f2004.eq(339).or(Mapb_f2004.eq(439)).or(Mapb_f2004.eq(539)).or(Mapb_f2004.eq(939)).or(Mapb_f2004.eq(1139)).
or(Mapb_f2004.eq(239)).or(Mapb_f2004.eq(3239)).or(Mapb_f2004.eq(2939)).or(Mapb_f2004.eq(1339)).or(Mapb_f2004.eq(1539)).
or(Mapb_f2004.eq(2039)).or(Mapb_f2004.eq(4139)).or(Mapb_f2004.eq(4639)).or(Mapb_f2004.eq(2139)).or(Mapb_f2004.eq(2339)).or(Mapb_f2004.eq(2439)).
or(Mapb_f2004.eq(3039)).or(Mapb_f2004.eq(2539)).or(Mapb_f2004.eq(3339)).or(Mapb_f2004.eq(2739)).or(Mapb_f2004.eq(39))

var Mapb_f2005 = trans_a.select('transition_2005_2006')
var Mapb_fa_2005 =  Mapb_fa_2004.eq(1).and(Mapb_f2005.gt(299).and(Mapb_f2005.lt(600)))

var Mapb_c_2006 = Mapb_f2005.eq(339).or(Mapb_f2005.eq(439)).or(Mapb_f2005.eq(539)).or(Mapb_f2005.eq(939)).or(Mapb_f2005.eq(1139)).
or(Mapb_f2005.eq(239)).or(Mapb_f2005.eq(3239)).or(Mapb_f2005.eq(2939)).or(Mapb_f2005.eq(1339)).or(Mapb_f2005.eq(1539)).
or(Mapb_f2005.eq(2039)).or(Mapb_f2005.eq(4139)).or(Mapb_f2005.eq(4639)).or(Mapb_f2005.eq(2139)).or(Mapb_f2005.eq(2339)).or(Mapb_f2005.eq(2439)).
or(Mapb_f2005.eq(3039)).or(Mapb_f2005.eq(2539)).or(Mapb_f2005.eq(3339)).or(Mapb_f2005.eq(2739)).or(Mapb_f2005.eq(39))

var Mapb_f2006 = trans_a.select('transition_2006_2007')
var Mapb_fa_2006 =  Mapb_fa_2005.eq(1).and(Mapb_f2006.gt(299).and(Mapb_f2006.lt(600)))

var Mapb_c_2007 = Mapb_f2006.eq(339).or(Mapb_f2006.eq(439)).or(Mapb_f2006.eq(539)).or(Mapb_f2006.eq(939)).or(Mapb_f2006.eq(1139)).
or(Mapb_f2006.eq(239)).or(Mapb_f2006.eq(3239)).or(Mapb_f2006.eq(2939)).or(Mapb_f2006.eq(1339)).or(Mapb_f2006.eq(1539)).
or(Mapb_f2006.eq(2039)).or(Mapb_f2006.eq(4139)).or(Mapb_f2006.eq(4639)).or(Mapb_f2006.eq(2139)).or(Mapb_f2006.eq(2339)).or(Mapb_f2006.eq(2439)).
or(Mapb_f2006.eq(3039)).or(Mapb_f2006.eq(2539)).or(Mapb_f2006.eq(3339)).or(Mapb_f2006.eq(2739)).or(Mapb_f2006.eq(39))

var Mapb_f2007 = trans_a.select('transition_2007_2008')
var Mapb_fa_2007 =  Mapb_fa_2006.eq(1).and(Mapb_f2007.gt(299).and(Mapb_f2007.lt(600)))

var Mapb_c_2008 = Mapb_f2007.eq(339).or(Mapb_f2007.eq(439)).or(Mapb_f2007.eq(539)).or(Mapb_f2007.eq(939)).or(Mapb_f2007.eq(1139)).
or(Mapb_f2007.eq(239)).or(Mapb_f2007.eq(3239)).or(Mapb_f2007.eq(2939)).or(Mapb_f2007.eq(1339)).or(Mapb_f2007.eq(1539)).
or(Mapb_f2007.eq(2039)).or(Mapb_f2007.eq(4139)).or(Mapb_f2007.eq(4639)).or(Mapb_f2007.eq(2139)).or(Mapb_f2007.eq(2339)).or(Mapb_f2007.eq(2439)).
or(Mapb_f2007.eq(3039)).or(Mapb_f2007.eq(2539)).or(Mapb_f2007.eq(3339)).or(Mapb_f2007.eq(2739)).or(Mapb_f2007.eq(39))

var Mapb_f2008 = trans_a.select('transition_2008_2009')
var Mapb_fa_2008 =  Mapb_fa_2007.eq(1).and(Mapb_f2008.gt(299).and(Mapb_f2008.lt(600)))


var Mapb_c_2009 = Mapb_f2008.eq(339).or(Mapb_f2008.eq(439)).or(Mapb_f2008.eq(539)).or(Mapb_f2008.eq(939)).or(Mapb_f2008.eq(1139)).
or(Mapb_f2008.eq(239)).or(Mapb_f2008.eq(3239)).or(Mapb_f2008.eq(2939)).or(Mapb_f2008.eq(1339)).or(Mapb_f2008.eq(1539)).
or(Mapb_f2008.eq(2039)).or(Mapb_f2008.eq(4139)).or(Mapb_f2008.eq(4639)).or(Mapb_f2008.eq(2139)).or(Mapb_f2008.eq(2339)).or(Mapb_f2008.eq(2439)).
or(Mapb_f2008.eq(3039)).or(Mapb_f2008.eq(2539)).or(Mapb_f2008.eq(3339)).or(Mapb_f2008.eq(2739)).or(Mapb_f2008.eq(39))

var Mapb_f2009 = trans_a.select('transition_2009_2010')
var Mapb_fa_2009 =  Mapb_fa_2008.eq(1).and(Mapb_f2009.gt(299).and(Mapb_f2009.lt(600)))


var Mapb_c_2010 = Mapb_f2009.eq(339).or(Mapb_f2009.eq(439)).or(Mapb_f2009.eq(539)).or(Mapb_f2009.eq(939)).or(Mapb_f2009.eq(1139)).
or(Mapb_f2009.eq(239)).or(Mapb_f2009.eq(3239)).or(Mapb_f2009.eq(2939)).or(Mapb_f2009.eq(1339)).or(Mapb_f2009.eq(1539)).
or(Mapb_f2009.eq(2039)).or(Mapb_f2009.eq(4139)).or(Mapb_f2009.eq(4639)).or(Mapb_f2009.eq(2139)).or(Mapb_f2009.eq(2339)).or(Mapb_f2009.eq(2439)).
or(Mapb_f2009.eq(3039)).or(Mapb_f2009.eq(2539)).or(Mapb_f2009.eq(3339)).or(Mapb_f2009.eq(2739)).or(Mapb_f2009.eq(39))

var Mapb_f2010 = trans_a.select('transition_2010_2011')
var Mapb_fa_2010 =  Mapb_fa_2009.eq(1).and(Mapb_f2010.gt(299).and(Mapb_f2010.lt(600)))


var Mapb_c_2011 = Mapb_f2010.eq(339).or(Mapb_f2010.eq(439)).or(Mapb_f2010.eq(539)).or(Mapb_f2010.eq(939)).or(Mapb_f2010.eq(1139)).
or(Mapb_f2010.eq(239)).or(Mapb_f2010.eq(3239)).or(Mapb_f2010.eq(2939)).or(Mapb_f2010.eq(1339)).or(Mapb_f2010.eq(1539)).
or(Mapb_f2010.eq(2039)).or(Mapb_f2010.eq(4139)).or(Mapb_f2010.eq(4639)).or(Mapb_f2010.eq(2139)).or(Mapb_f2010.eq(2339)).or(Mapb_f2010.eq(2439)).
or(Mapb_f2010.eq(3039)).or(Mapb_f2010.eq(2539)).or(Mapb_f2010.eq(3339)).or(Mapb_f2010.eq(2739)).or(Mapb_f2010.eq(39))

var Mapb_f2011 = trans_a.select('transition_2011_2012')
var Mapb_fa_2011 =  Mapb_fa_2010.eq(1).and(Mapb_f2011.gt(299).and(Mapb_f2011.lt(600)))


var Mapb_c_2012 = Mapb_f2011.eq(339).or(Mapb_f2011.eq(439)).or(Mapb_f2011.eq(539)).or(Mapb_f2011.eq(939)).or(Mapb_f2011.eq(1139)).
or(Mapb_f2011.eq(239)).or(Mapb_f2011.eq(3239)).or(Mapb_f2011.eq(2939)).or(Mapb_f2011.eq(1339)).or(Mapb_f2011.eq(1539)).
or(Mapb_f2011.eq(2039)).or(Mapb_f2011.eq(4139)).or(Mapb_f2011.eq(4639)).or(Mapb_f2011.eq(2139)).or(Mapb_f2011.eq(2339)).or(Mapb_f2011.eq(2439)).
or(Mapb_f2011.eq(3039)).or(Mapb_f2011.eq(2539)).or(Mapb_f2011.eq(3339)).or(Mapb_f2011.eq(2739)).or(Mapb_f2011.eq(39))

var Mapb_f2012 = trans_a.select('transition_2012_2013')
var Mapb_fa_2012 =  Mapb_fa_2011.eq(1).and(Mapb_f2012.gt(299).and(Mapb_f2012.lt(600)))


var Mapb_c_2013 = Mapb_f2012.eq(339).or(Mapb_f2012.eq(439)).or(Mapb_f2012.eq(539)).or(Mapb_f2012.eq(939)).or(Mapb_f2012.eq(1139)).
or(Mapb_f2012.eq(239)).or(Mapb_f2012.eq(3239)).or(Mapb_f2012.eq(2939)).or(Mapb_f2012.eq(1339)).or(Mapb_f2012.eq(1539)).
or(Mapb_f2012.eq(2039)).or(Mapb_f2012.eq(4139)).or(Mapb_f2012.eq(4639)).or(Mapb_f2012.eq(2139)).or(Mapb_f2012.eq(2339)).or(Mapb_f2012.eq(2439)).
or(Mapb_f2012.eq(3039)).or(Mapb_f2012.eq(2539)).or(Mapb_f2012.eq(3339)).or(Mapb_f2012.eq(2739)).or(Mapb_f2012.eq(39))

var Mapb_f2013 = trans_a.select('transition_2013_2014')
var Mapb_fa_2013 =  Mapb_fa_2012.eq(1).and(Mapb_f2013.gt(299).and(Mapb_f2013.lt(600)))


var Mapb_c_2014 = Mapb_f2013.eq(339).or(Mapb_f2013.eq(439)).or(Mapb_f2013.eq(539)).or(Mapb_f2013.eq(939)).or(Mapb_f2013.eq(1139)).
or(Mapb_f2013.eq(239)).or(Mapb_f2013.eq(3239)).or(Mapb_f2013.eq(2939)).or(Mapb_f2013.eq(1339)).or(Mapb_f2013.eq(1539)).
or(Mapb_f2013.eq(2039)).or(Mapb_f2013.eq(4139)).or(Mapb_f2013.eq(4639)).or(Mapb_f2013.eq(2139)).or(Mapb_f2013.eq(2339)).or(Mapb_f2013.eq(2439)).
or(Mapb_f2013.eq(3039)).or(Mapb_f2013.eq(2539)).or(Mapb_f2013.eq(3339)).or(Mapb_f2013.eq(2739)).or(Mapb_f2013.eq(39))


var Mapb_f2014 = trans_a.select('transition_2014_2015')
var Mapb_fa_2014 =  Mapb_fa_2013.eq(1).and(Mapb_f2014.gt(299).and(Mapb_f2014.lt(600)))


var Mapb_c_2015 = Mapb_f2014.eq(339).or(Mapb_f2014.eq(439)).or(Mapb_f2014.eq(539)).or(Mapb_f2014.eq(939)).or(Mapb_f2014.eq(1139)).
or(Mapb_f2014.eq(239)).or(Mapb_f2014.eq(3239)).or(Mapb_f2014.eq(2939)).or(Mapb_f2014.eq(1339)).or(Mapb_f2014.eq(1539)).
or(Mapb_f2014.eq(2039)).or(Mapb_f2014.eq(4139)).or(Mapb_f2014.eq(4639)).or(Mapb_f2014.eq(2139)).or(Mapb_f2014.eq(2339)).or(Mapb_f2014.eq(2439)).
or(Mapb_f2014.eq(3039)).or(Mapb_f2014.eq(2539)).or(Mapb_f2014.eq(3339)).or(Mapb_f2014.eq(2739)).or(Mapb_f2014.eq(39))

var Mapb_f2015 = trans_a.select('transition_2015_2016')
var Mapb_fa_2015 =  Mapb_fa_2014.eq(1).and(Mapb_f2015.gt(299).and(Mapb_f2015.lt(600)))

var Mapb_c_2016 = Mapb_f2015.eq(339).or(Mapb_f2015.eq(439)).or(Mapb_f2015.eq(539)).or(Mapb_f2015.eq(939)).or(Mapb_f2015.eq(1139)).
or(Mapb_f2015.eq(239)).or(Mapb_f2015.eq(3239)).or(Mapb_f2015.eq(2939)).or(Mapb_f2015.eq(1339)).or(Mapb_f2015.eq(1539)).
or(Mapb_f2015.eq(2039)).or(Mapb_f2015.eq(4139)).or(Mapb_f2015.eq(4639)).or(Mapb_f2015.eq(2139)).or(Mapb_f2015.eq(2339)).or(Mapb_f2015.eq(2439)).
or(Mapb_f2015.eq(3039)).or(Mapb_f2015.eq(2539)).or(Mapb_f2015.eq(3339)).or(Mapb_f2015.eq(2739)).or(Mapb_f2015.eq(39))

var Mapb_f2016 = trans_a.select('transition_2016_2017')
var Mapb_fa_2016 =  Mapb_fa_2015.eq(1).and(Mapb_f2016.gt(299).and(Mapb_f2016.lt(600)))


var Mapb_c_2017 = Mapb_f2016.eq(339).or(Mapb_f2016.eq(439)).or(Mapb_f2016.eq(539)).or(Mapb_f2016.eq(939)).or(Mapb_f2016.eq(1139)).
or(Mapb_f2016.eq(239)).or(Mapb_f2016.eq(3239)).or(Mapb_f2016.eq(2939)).or(Mapb_f2016.eq(1339)).or(Mapb_f2016.eq(1539)).
or(Mapb_f2016.eq(2039)).or(Mapb_f2016.eq(4139)).or(Mapb_f2016.eq(4639)).or(Mapb_f2016.eq(2139)).or(Mapb_f2016.eq(2339)).or(Mapb_f2016.eq(2439)).
or(Mapb_f2016.eq(3039)).or(Mapb_f2016.eq(2539)).or(Mapb_f2016.eq(3339)).or(Mapb_f2016.eq(2739)).or(Mapb_f2016.eq(39))

var Mapb_f2017 = trans_a.select('transition_2017_2018')
var Mapb_fa_2017 =  Mapb_fa_2016.eq(1).and(Mapb_f2017.gt(299).and(Mapb_f2017.lt(600)))


var Mapb_c_2018 = Mapb_f2017.eq(339).or(Mapb_f2017.eq(439)).or(Mapb_f2017.eq(539)).or(Mapb_f2017.eq(939)).or(Mapb_f2017.eq(1139)).
or(Mapb_f2017.eq(239)).or(Mapb_f2017.eq(3239)).or(Mapb_f2017.eq(2939)).or(Mapb_f2017.eq(1339)).or(Mapb_f2017.eq(1539)).
or(Mapb_f2017.eq(2039)).or(Mapb_f2017.eq(4139)).or(Mapb_f2017.eq(4639)).or(Mapb_f2017.eq(2139)).or(Mapb_f2017.eq(2339)).or(Mapb_f2017.eq(2439)).
or(Mapb_f2017.eq(3039)).or(Mapb_f2017.eq(2539)).or(Mapb_f2017.eq(3339)).or(Mapb_f2017.eq(2739)).or(Mapb_f2017.eq(39))

var Mapb_f2018 = trans_a.select('transition_2018_2019')
var Mapb_fa_2018 =  Mapb_fa_2017.eq(1).and(Mapb_f2018.gt(299).and(Mapb_f2018.lt(600)))
//Map.addLayer(Mapb_fa_2018,{}, "forest2018")

var Mapb_c_2019 = Mapb_f2018.eq(339).or(Mapb_f2018.eq(439)).or(Mapb_f2018.eq(539)).or(Mapb_f2018.eq(939)).or(Mapb_f2018.eq(1139)).
or(Mapb_f2018.eq(239)).or(Mapb_f2018.eq(3239)).or(Mapb_f2018.eq(2939)).or(Mapb_f2018.eq(1339)).or(Mapb_f2018.eq(1539)).
or(Mapb_f2018.eq(2039)).or(Mapb_f2018.eq(4139)).or(Mapb_f2018.eq(4639)).or(Mapb_f2018.eq(2139)).or(Mapb_f2018.eq(2339)).or(Mapb_f2018.eq(2439)).
or(Mapb_f2018.eq(3039)).or(Mapb_f2018.eq(2539)).or(Mapb_f2018.eq(3339)).or(Mapb_f2018.eq(2739)).or(Mapb_f2018.eq(39))

var Mapb_f2019 = trans_a.select('transition_2018_2019')
var Mapb_fa_2019 =  Mapb_fa_2018.eq(1).and(Mapb_f2019.eq(339).or(Mapb_f2019.eq(439)).or(Mapb_f2019.eq(539)))// only def for soy
//Map.addLayer(Mapb_fa_2019,{}, "forest2019")

//identify deforestation for soybeans within 5 years past deforestation (forest in t-1 and turned into cropland at t,t+1, t+2, t+3, t+4, t+5)
// corrected to only count the year specific deforestation events (prior only forest and soy defoed, not non-forest in the subsequent year)

var defC_2001 = (Mapb_fa_2000.eq(1).and(Mapb_fa_2001.neq(1))).and((Mapb_c_2001.eq(1)).or(Mapb_c_2002.eq(1)).or(Mapb_c_2003.eq(1)).or(Mapb_c_2004.eq(1)).or(Mapb_c_2005.eq(1)))
var defC_2002 = (Mapb_fa_2001.eq(1).and(Mapb_fa_2002.neq(1))).and((Mapb_c_2002.eq(1)).or(Mapb_c_2003.eq(1)).or(Mapb_c_2004.eq(1)).or(Mapb_c_2005.eq(1)).or(Mapb_c_2006.eq(1)))
var defC_2003 = (Mapb_fa_2002.eq(1).and(Mapb_fa_2003.neq(1))).and((Mapb_c_2003.eq(1)).or(Mapb_c_2004.eq(1)).or(Mapb_c_2005.eq(1)).or(Mapb_c_2006.eq(1)).or(Mapb_c_2007.eq(1)))
var defC_2004 = (Mapb_fa_2003.eq(1).and(Mapb_fa_2004.neq(1))).and((Mapb_c_2004.eq(1)).or(Mapb_c_2005.eq(1)).or(Mapb_c_2006.eq(1)).or(Mapb_c_2007.eq(1)).or(Mapb_c_2008.eq(1)))
var defC_2005 = (Mapb_fa_2004.eq(1).and(Mapb_fa_2005.neq(1))).and((Mapb_c_2005.eq(1)).or(Mapb_c_2006.eq(1)).or(Mapb_c_2007.eq(1)).or(Mapb_c_2008.eq(1)).or(Mapb_c_2009.eq(1)))
var defC_2006 = (Mapb_fa_2005.eq(1).and(Mapb_fa_2006.neq(1))).and((Mapb_c_2006.eq(1)).or(Mapb_c_2007.eq(1)).or(Mapb_c_2008.eq(1)).or(Mapb_c_2009.eq(1)).or(Mapb_c_2010.eq(1)))
var defC_2007 = (Mapb_fa_2006.eq(1).and(Mapb_fa_2007.neq(1))).and((Mapb_c_2007.eq(1)).or(Mapb_c_2008.eq(1)).or(Mapb_c_2009.eq(1)).or(Mapb_c_2010.eq(1)).or(Mapb_c_2011.eq(1)))
var defC_2008 = (Mapb_fa_2007.eq(1).and(Mapb_fa_2008.neq(1))).and((Mapb_c_2008.eq(1)).or(Mapb_c_2009.eq(1)).or(Mapb_c_2010.eq(1)).or(Mapb_c_2011.eq(1)).or(Mapb_c_2012.eq(1)))
var defC_2009 = (Mapb_fa_2008.eq(1).and(Mapb_fa_2009.neq(1))).and((Mapb_c_2009.eq(1)).or(Mapb_c_2010.eq(1)).or(Mapb_c_2011.eq(1)).or(Mapb_c_2012.eq(1)).or(Mapb_c_2013.eq(1)))
var defC_2010 = (Mapb_fa_2009.eq(1).and(Mapb_fa_2010.neq(1))).and((Mapb_c_2010.eq(1)).or(Mapb_c_2011.eq(1)).or(Mapb_c_2012.eq(1)).or(Mapb_c_2013.eq(1)).or(Mapb_c_2014.eq(1)))
var defC_2011 = (Mapb_fa_2010.eq(1).and(Mapb_fa_2011.neq(1))).and((Mapb_c_2011.eq(1)).or(Mapb_c_2012.eq(1)).or(Mapb_c_2013.eq(1)).or(Mapb_c_2014.eq(1)).or(Mapb_c_2015.eq(1)))
var defC_2012 = (Mapb_fa_2011.eq(1).and(Mapb_fa_2012.neq(1))).and((Mapb_c_2012.eq(1)).or(Mapb_c_2013.eq(1)).or(Mapb_c_2014.eq(1)).or(Mapb_c_2015.eq(1)).or(Mapb_c_2016.eq(1)))
var defC_2013 = (Mapb_fa_2012.eq(1).and(Mapb_fa_2013.neq(1))).and((Mapb_c_2013.eq(1)).or(Mapb_c_2014.eq(1)).or(Mapb_c_2015.eq(1)).or(Mapb_c_2016.eq(1)).or(Mapb_c_2017.eq(1)))
var defC_2014 = (Mapb_fa_2013.eq(1).and(Mapb_fa_2014.neq(1))).and((Mapb_c_2014.eq(1)).or(Mapb_c_2015.eq(1)).or(Mapb_c_2016.eq(1)).or(Mapb_c_2017.eq(1)).or(Mapb_c_2018.eq(1)))
var defC_2015 = (Mapb_fa_2014.eq(1).and(Mapb_fa_2015.neq(1))).and((Mapb_c_2015.eq(1)).or(Mapb_c_2016.eq(1)).or(Mapb_c_2017.eq(1)).or(Mapb_c_2018.eq(1)).or(Mapb_c_2019.eq(1))
var defC_2016 = (Mapb_fa_2015.eq(1).and(Mapb_fa_2016.neq(1))).and((Mapb_c_2016.eq(1)).or(Mapb_c_2017.eq(1)).or(Mapb_c_2018.eq(1)).or(Mapb_c_2019.eq(1)))
var defC_2017 = (Mapb_fa_2016.eq(1).and(Mapb_fa_2017.neq(1))).and((Mapb_c_2017.eq(1)).or(Mapb_c_2018.eq(1)).or(Mapb_c_2019.eq(1)))
var defC_2018 = (Mapb_fa_2017.eq(1).and(Mapb_fa_2018.neq(1))).and((Mapb_c_2018.eq(1)).or(Mapb_c_2019.eq(1)))
var defC_2019 = (Mapb_fa_2018.eq(1).and(Mapb_fa_2019.neq(1))).and(Mapb_c_2019.eq(1))



//assign year to those pixels identified as deforestation for soy (1) 
var defC_2001A = defC_2001.multiply(2001)
var defC_2002A = defC_2002.multiply(2002)
var defC_2003A = defC_2003.multiply(2003)
var defC_2004A = defC_2004.multiply(2004)
var defC_2005A = defC_2005.multiply(2005)
var defC_2006A = defC_2006.multiply(2006)
var defC_2007A = defC_2007.multiply(2007)
var defC_2008A = defC_2008.multiply(2008)
var defC_2009A = defC_2009.multiply(2009)
var defC_2010A = defC_2010.multiply(2010)
var defC_2011A = defC_2011.multiply(2011)
var defC_2012A = defC_2012.multiply(2012)
var defC_2013A = defC_2013.multiply(2013)
var defC_2014A = defC_2014.multiply(2014);
var defC_2015A = defC_2015.multiply(2015);
var defC_2016A = defC_2016.multiply(2016);
var defC_2017A = defC_2017.multiply(2017);
var defC_2018A = defC_2018.multiply(2018);
var defC_2019A = defC_2019.multiply(2019);
//
//soy 2019
var Mapb_2019 = MapBiomas.select('classification_2019');
var Soy_2019 = Mapb_2019.eq(39);
var Pasture_2019 = Mapb_2019.eq(15).or(Mapb_2019.eq(21));
var Crop_2019 =  Mapb_2019.eq(20).or(Mapb_2019.eq(41));
var Forest_2019 = Mapb_2019.eq(3).or(Mapb_2019.eq(4)).or(Mapb_2019.eq(5));
var Water_2019 = Mapb_2019.eq(26).or(Mapb_2019.eq(33)).or(Mapb_2019.eq(31));
var Grass_2019 = Mapb_2019.eq(12);


//Map.addLayer(Pasture_2019,{}, "pasture2019")
//Map.addLayer(Pasture_2019a,{}, "pasture2019a")
//Map.addLayer(Pasture_2019b,{}, "pasture2019b")

// GAEZ apt
var GAEZSuit = ee.Image('users/floriangollnow/GAEZ/GAEZ_SoySuitability')
var GAEZSuit_m = GAEZSuit.gte(1).and(GAEZSuit.lte(4))

//var apt = ee.Image ('users/floriangollnow/UFMT/_aptidao_soja_wgs84')//500m
var apt = ee.Image('users/floriangollnow/UFMT/apt_mechanized_crop_60')//60m
var apt_rp = apt.reproject({
    crs: 'EPSG:4326',
    scale: 60
}) 

var apt_m = apt_rp.gt(0)


var suit_mask = GAEZSuit_m.eq(1).and(apt_m.eq(1));


var SuitForest_2019 = Forest_2019.multiply(suit_mask);

var FFS_2019 = Forest_2019.add(SuitForest_2019); // 1Forest, 2 Suit Forest (1+1)
//Map.addLayer(FFS_2019.clip(bla),{}, "FFS");
var LU_2019 = Crop_2019.multiply(4).add(Pasture_2019.multiply(3)).add(Grass_2019.multiply(5)).add(Water_2019.multiply(6));//4crop, 3pasture, 5 water
//Map.addLayer(LU_2019,{}, "LU2019")
//Map.addLayer(Mapb_2019,{}, "Map2019")


//only def without year
var stacked_Def = defC_2001A.add(defC_2002A).add(defC_2003A).add(defC_2004A).
add(defC_2005A).add(defC_2006A).add(defC_2007A).add(defC_2008A).
add(defC_2009A).add(defC_2010A).add(defC_2011A).add(defC_2012A).add(defC_2013A).add(defC_2014A).
add(defC_2015A).add(defC_2016A).add(defC_2017A).add(defC_2018A).add(defC_2019A).rename ('SoyDeforestation');


var Soy_masked = Soy_2019.eq(1).and(stacked_Def.lt(2000));//only soy without def.. (lt= less than)

var stacked_Def2 = stacked_Def.gt(2000).multiply(2).add(stacked_Def.gt(2010)).add(Soy_masked);//1 Soy, 2 Soydef >2000<=2010, 3 soydef>2010
//Map.addLayer(stacked_Def2.clip(bla),{}, "sdef");

var FFSS_2019 = stacked_Def2.multiply(10).add(FFS_2019).add(LU_2019);// 10 Soy, 20 Soy def200-2010, 30 soydef 2010-2018, 1 Forest, 2 Suitable Forest, 3Pasture, 4Crop

var FFSS_2019_rec = FFSS_2019.remap([1,2,3,4,5,6,10,20,21,22,23,24,30,31,32,33,34],[1,2,3,4,8,9,5,6,6,6,6,6,7,7,7,7,7]);
//1 Forest, 2 Suitable Forest, 3Pasture, 4Crop,8 grassland, 9 water, 5 soy , 6 soy-def 00-10,7 soy-def 11-18 


//export
Export.image.toDrive({
  image: FFSS_2019_rec.clip(cerr),
  description: 'mapbiomas_FFSS_GAEZapt_Cerrado_1000_v5',
  folder: 'MapBiomas',
  scale: 1000,
  maxPixels: 2e10,
  region: cerr
});
Export.image.toDrive({
  image: FFSS_2019_rec.clip(ama),
  description: 'mapbiomas_FFSS_GAEZapt_Amazon_1000_v5',
  folder: 'MapBiomas',
  scale: 1000,
  maxPixels: 2e10,
  region: ama
});

//export
Export.image.toDrive({
  image: FFSS_2019_rec.clip(cerr),
  description: 'mapbiomas_FFSS_GAEZapt_Cerrado_500_v5',
  folder: 'MapBiomas',
  scale: 500,
  maxPixels: 2e10,
  region: cerr
});

Export.image.toDrive({
  image: FFSS_2019_rec.clip(ama),
  description: 'mapbiomas_FFSS_GAEZapt_Amazon_500_v5',
  folder: 'MapBiomas',
  scale: 500,
  maxPixels: 2e10,
  region: ama
});

// only soy def, all else NA

var stacked_soydef_only = stacked_Def.gt(2000).add(stacked_Def.gt(2010));// 1 soy def >2000<=2010, 2 soy def>2010

Export.image.toDrive({
  image: stacked_soydef_only.clip(cerr),
  description: 'mapbiomas_SDEF_Cerrado_1000_v5',
  folder: 'MapBiomas',
  scale: 1000,
  maxPixels: 2e10,
  region: cerr
});
Export.image.toDrive({
  image: stacked_soydef_only.clip(ama),
  description: 'mapbiomas_SDEF_Amazon_1000_v5',
  folder: 'MapBiomas',
  scale: 1000,
  maxPixels: 2e10,
  region: ama
});

//export
Export.image.toDrive({
  image: stacked_soydef_only.clip(cerr),
  description: 'mapbiomas_SDEF_Cerrado_500_v5',
  folder: 'MapBiomas',
  scale: 500,
  maxPixels: 2e10,
  region: cerr
});

Export.image.toDrive({
  image: stacked_soydef_only.clip(ama),
  description: 'mapbiomas_SDEF_Amazon_500_v5',
  folder: 'MapBiomas',
  scale: 500,
  maxPixels: 2e10,
  region: ama
});





