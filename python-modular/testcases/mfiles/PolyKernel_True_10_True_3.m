functionname = 'test_poly_kernel'
kernelname = 'PolyKernel'
testdat = [0.781662498, 0.0990625305, 0.730797516, 0.66048147, 0.825170422, 0.624677135, 0.197281233, 0.51152901, 0.937429097, 0.431272401, 0.509876378, 0.120511556, 0.570307902, 0.746755131, 0.679265327, 0.102757904, 0.28977822;0.166350049, 0.620614932, 0.326881766, 0.276352604, 0.975507789, 0.253206846, 0.0773190627, 0.88897015, 0.0793067544, 0.722271828, 0.690655873, 0.107798383, 0.0679906968, 0.49532125, 0.861928713, 0.293736854, 0.393090711;0.798522276, 0.0571420834, 0.244043635, 0.767659161, 0.335080025, 0.453867889, 0.104553171, 0.656946987, 0.461321395, 0.108105602, 0.303249349, 0.52996727, 0.260020228, 0.581237881, 0.630018929, 0.667085187, 0.129395046;0.548054159, 0.297778185, 0.105591552, 0.857487699, 0.990628151, 0.995069536, 0.69665515, 0.884292149, 0.701540696, 0.371784813, 0.327005665, 0.382302598, 0.00770530154, 0.492972471, 0.0828863642, 0.53588686, 0.15742513;0.540642365, 0.792006017, 0.569560454, 0.250447487, 0.101276874, 0.182087999, 0.436636801, 0.928849805, 0.0264641003, 0.0932459772, 0.499969322, 0.19272229, 0.385898755, 0.39198164, 0.561377761, 0.170386832, 0.252449327;0.816205849, 0.628733341, 0.687355589, 0.72754033, 0.0399807559, 0.253435971, 0.932401752, 0.177487914, 0.458671884, 0.916210266, 0.55520353, 0.421089544, 0.543712439, 0.685361997, 0.899365409, 0.16122919, 0.538015857;0.801800479, 0.969126527, 0.933713243, 0.272786717, 0.604642814, 0.709902934, 0.456380931, 0.87584988, 0.138367002, 0.894877155, 0.68152783, 0.322927619, 0.778112046, 0.401115833, 0.327879177, 0.101572009, 0.940221658;0.978346884, 0.748195591, 0.864115281, 0.683102881, 0.55102259, 0.185069519, 0.693198242, 0.0792878083, 0.649876534, 0.53553553, 0.377017953, 0.966624739, 0.92826567, 0.654260529, 0.0724753837, 0.972970421, 0.302854293;0.814629185, 0.649884548, 0.394796474, 0.399394482, 0.178017387, 0.339332579, 0.144877044, 0.102702223, 0.718497546, 0.567790653, 0.757971393, 0.304278821, 0.260463218, 0.100065418, 0.988486505, 0.676934383, 0.360694105;0.0453608573, 0.246115669, 0.728874156, 0.175892097, 0.801240728, 0.502439597, 0.849997394, 0.00159542335, 0.349660805, 0.498534114, 0.544424088, 0.107700532, 0.612786479, 0.464879632, 0.86151129, 0.274085488, 0.657716509;0.0960156344, 0.754328799, 0.946693268, 0.843204976, 0.375786077, 0.592829901, 0.474940287, 0.288765441, 0.629586417, 0.512103859, 0.782732148, 0.0530442411, 0.604560719, 0.254532477, 0.696475134, 0.80533672, 0.507645956]
km_test = [0.402807166, 0.741046513, 0.789564731, 0.663433329, 0.516657478, 0.657153228, 0.689141808, 0.46553841, 0.526973085, 0.607927343, 0.783016328, 0.430606996, 0.696051141, 0.605790315, 0.522225632, 0.625297554, 0.706984359;0.352005988, 0.446041841, 0.354024545, 0.629246983, 0.468334451, 0.461648088, 0.290348151, 0.57394076, 0.371483183, 0.388458137, 0.51955229, 0.455579721, 0.302926502, 0.526539353, 0.389604463, 0.654455291, 0.34040311;0.679194335, 0.696436843, 0.422453219, 0.453726209, 0.330752494, 0.430426999, 0.406975811, 0.628822559, 0.340338034, 0.490802235, 0.619151741, 0.568415685, 0.395726273, 0.513418443, 0.476531682, 0.46905444, 0.475875741;0.586409865, 0.470596121, 0.553731017, 0.444520218, 0.462262174, 0.560938868, 0.570734159, 0.313430707, 0.553308983, 0.775855684, 0.652423751, 0.357580387, 0.517995216, 0.615156427, 0.598373955, 0.236939242, 0.685469377;0.3283266, 0.341130546, 0.433430002, 0.477527397, 0.306172891, 0.426843911, 0.225733588, 0.340389968, 0.497961439, 0.290636414, 0.632244952, 0.200068164, 0.336547671, 0.399467486, 0.719616222, 0.470472506, 0.351842871;0.591455095, 0.556733411, 0.601197321, 0.512837576, 0.722516949, 0.772297564, 0.500337138, 0.619241247, 0.537303566, 0.604602375, 0.74810372, 0.466438431, 0.564845257, 0.663737807, 0.587100817, 0.475314337, 0.707818808;0.399901877, 0.405901107, 0.500575767, 0.455331884, 0.619293734, 0.663960421, 0.679356041, 0.518098048, 0.389678661, 0.629320227, 0.578612067, 0.268402143, 0.421669015, 0.697072908, 0.532638754, 0.188578104, 0.63313952;0.656608928, 0.446967471, 0.6913254, 0.616506741, 0.573460419, 0.639311288, 0.684464879, 0.374067716, 0.543340815, 0.645941913, 0.566381549, 0.623821824, 0.751166467, 0.817693465, 0.454863288, 0.444605642, 0.685040949;0.748741008, 0.506598693, 0.484262274, 0.761914369, 0.692307113, 0.626518632, 0.472886545, 0.611858842, 0.666503015, 0.59999748, 0.650691808, 0.640802223, 0.44495953, 0.821355725, 0.541019455, 0.614305521, 0.434107688;0.577120065, 0.346782904, 0.3914807, 0.535615485, 0.581171143, 0.485937879, 0.419418716, 0.28529998, 0.658175503, 0.511979022, 0.573752145, 0.554970672, 0.395220142, 0.620690227, 0.593333777, 0.597806889, 0.402201046;0.539258319, 0.719708451, 0.775831952, 0.648703895, 0.495808341, 0.606494368, 0.58063136, 0.442403085, 0.538522072, 0.918217186, 0.882821108, 0.403672104, 0.65948451, 0.687835661, 0.748743725, 0.444103766, 0.844934951;0.453828413, 0.644646073, 0.352733527, 0.418081628, 0.372192708, 0.328151703, 0.381230328, 0.42292382, 0.369485192, 0.423508287, 0.546854102, 0.465226292, 0.302649993, 0.405880654, 0.361476663, 0.539354689, 0.314455245;0.536956126, 0.785364625, 0.752216723, 0.56658739, 0.465241307, 0.553400929, 0.527913395, 0.397391061, 0.601009658, 0.795987883, 0.956205928, 0.388058271, 0.63023871, 0.576678824, 0.819018187, 0.531956125, 0.763902409]
traindat = [0.237647629, 0.0584100077, 0.0252256721, 0.772557209, 0.728082346, 0.502987388, 0.709640741, 0.597553176, 0.718970516, 0.548809309, 0.472040552, 0.070587926, 0.459950614;0.320434673, 0.874704169, 0.517893009, 0.318035461, 0.431837482, 0.447975678, 0.589099194, 0.213923396, 0.90175492, 0.644874407, 0.645945585, 0.85694173, 0.548117546;0.196979986, 0.867267731, 0.580767859, 0.000660197094, 0.89277055, 0.532167789, 0.231852785, 0.826069503, 0.82077546, 0.677722302, 0.32355208, 0.00736405016, 0.0930591026;0.426949643, 0.520936471, 0.521816548, 0.44914082, 0.116945471, 0.557450281, 0.901296335, 0.471463836, 0.935837131, 0.597119402, 0.212608806, 0.820060087, 0.184152972;0.547263013, 0.324316086, 0.949500975, 0.159888275, 0.766903067, 0.464169584, 0.538579328, 0.141816648, 0.443435211, 0.106909611, 0.165978197, 0.965470633, 0.440684173;0.326312722, 0.184782651, 0.430428631, 0.900728303, 0.100951308, 0.0776521927, 0.946910946, 0.701053173, 0.563118253, 0.370045668, 0.865613857, 0.311643027, 0.531513917;0.451755145, 0.213340679, 0.645886951, 0.689764033, 0.0314995505, 0.772728487, 0.732833787, 0.896700956, 0.382952779, 0.0933191234, 0.733764754, 0.17144842, 0.473841517;0.474683094, 0.478775852, 0.496046484, 0.205300086, 0.000214442063, 0.330798525, 0.0284133884, 0.789781519, 0.851090231, 0.731277509, 0.286708213, 0.933634373, 0.332818418;0.190744861, 0.129934084, 0.805658435, 0.709407613, 0.911662267, 0.587120072, 0.0913291125, 0.128522461, 0.629600337, 0.994929146, 0.438754312, 0.950168562, 0.838490868;0.489599855, 0.00953023685, 0.116191522, 0.58490428, 0.56903033, 0.721767724, 0.987558845, 0.877308831, 0.281985162, 0.770616404, 0.377956562, 0.0942927116, 0.427355373;0.960108176, 0.75310023, 0.0637402514, 0.0204266992, 0.973134813, 0.197727131, 0.151462995, 0.253458299, 0.220714416, 0.00446705771, 0.745961529, 0.333820267, 0.672055256]
km_train = [1, 0.58095723, 0.465821999, 0.379734257, 0.517125334, 0.586570895, 0.482594097, 0.521848432, 0.485812269, 0.353782866, 0.691301155, 0.476036112, 0.717297441;0.58095723, 1, 0.474281446, 0.15878333, 0.440189564, 0.42942208, 0.255191667, 0.366290868, 0.631088998, 0.385864208, 0.496660819, 0.435169004, 0.418970411;0.465821999, 0.474281446, 1, 0.421541628, 0.394723758, 0.658328954, 0.389383948, 0.411610884, 0.658057627, 0.508859558, 0.462300222, 0.718814481, 0.582978518;0.379734257, 0.15878333, 0.421541628, 1, 0.268669231, 0.602812071, 0.720164162, 0.568054956, 0.511441997, 0.541526197, 0.673327647, 0.310596926, 0.673101481;0.517125334, 0.440189564, 0.394723758, 0.268669231, 1, 0.521915163, 0.260323048, 0.283411309, 0.417985138, 0.444018614, 0.440968463, 0.300126544, 0.616009132;0.586570895, 0.42942208, 0.658328954, 0.602812071, 0.521915163, 1, 0.630331868, 0.691067502, 0.680051274, 0.676544566, 0.571415275, 0.445951612, 0.65044097;0.482594097, 0.255191667, 0.389383948, 0.720164162, 0.260323048, 0.630331868, 1, 0.623886882, 0.521927005, 0.413925023, 0.594287039, 0.269792912, 0.487183262;0.521848432, 0.366290868, 0.411610884, 0.568054956, 0.283411309, 0.691067502, 0.623886882, 1, 0.60694054, 0.546684755, 0.615853127, 0.219401654, 0.450798696;0.485812269, 0.631088998, 0.658057627, 0.511441997, 0.417985138, 0.680051274, 0.521927005, 0.60694054, 1, 0.77669529, 0.566095359, 0.62280628, 0.565800217;0.353782866, 0.385864208, 0.508859558, 0.541526197, 0.444018614, 0.676544566, 0.413925023, 0.546684755, 0.77669529, 1, 0.440236522, 0.496794804, 0.559196652;0.691301155, 0.496660819, 0.462300222, 0.673327647, 0.440968463, 0.571415275, 0.594287039, 0.615853127, 0.566095359, 0.440236522, 1, 0.34736215, 0.8262888;0.476036112, 0.435169004, 0.718814481, 0.310596926, 0.300126544, 0.445951612, 0.269792912, 0.219401654, 0.62280628, 0.496794804, 0.34736215, 1, 0.570975538;0.717297441, 0.418970411, 0.582978518, 0.673101481, 0.616009132, 0.65044097, 0.487183262, 0.450798696, 0.565800217, 0.559196652, 0.8262888, 0.570975538, 1]
use_norm= 'True' 
size_= 10 
inhom= 'True' 
degree= 3 
