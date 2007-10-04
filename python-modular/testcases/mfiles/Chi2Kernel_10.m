functionname = 'test_chi2_kernel'
kernelname = 'Chi2Kernel'
testdat = [0.781662498, 0.0990625305, 0.730797516, 0.66048147, 0.825170422, 0.624677135, 0.197281233, 0.51152901, 0.937429097, 0.431272401, 0.509876378, 0.120511556, 0.570307902, 0.746755131, 0.679265327, 0.102757904, 0.28977822;0.166350049, 0.620614932, 0.326881766, 0.276352604, 0.975507789, 0.253206846, 0.0773190627, 0.88897015, 0.0793067544, 0.722271828, 0.690655873, 0.107798383, 0.0679906968, 0.49532125, 0.861928713, 0.293736854, 0.393090711;0.798522276, 0.0571420834, 0.244043635, 0.767659161, 0.335080025, 0.453867889, 0.104553171, 0.656946987, 0.461321395, 0.108105602, 0.303249349, 0.52996727, 0.260020228, 0.581237881, 0.630018929, 0.667085187, 0.129395046;0.548054159, 0.297778185, 0.105591552, 0.857487699, 0.990628151, 0.995069536, 0.69665515, 0.884292149, 0.701540696, 0.371784813, 0.327005665, 0.382302598, 0.00770530154, 0.492972471, 0.0828863642, 0.53588686, 0.15742513;0.540642365, 0.792006017, 0.569560454, 0.250447487, 0.101276874, 0.182087999, 0.436636801, 0.928849805, 0.0264641003, 0.0932459772, 0.499969322, 0.19272229, 0.385898755, 0.39198164, 0.561377761, 0.170386832, 0.252449327;0.816205849, 0.628733341, 0.687355589, 0.72754033, 0.0399807559, 0.253435971, 0.932401752, 0.177487914, 0.458671884, 0.916210266, 0.55520353, 0.421089544, 0.543712439, 0.685361997, 0.899365409, 0.16122919, 0.538015857;0.801800479, 0.969126527, 0.933713243, 0.272786717, 0.604642814, 0.709902934, 0.456380931, 0.87584988, 0.138367002, 0.894877155, 0.68152783, 0.322927619, 0.778112046, 0.401115833, 0.327879177, 0.101572009, 0.940221658;0.978346884, 0.748195591, 0.864115281, 0.683102881, 0.55102259, 0.185069519, 0.693198242, 0.0792878083, 0.649876534, 0.53553553, 0.377017953, 0.966624739, 0.92826567, 0.654260529, 0.0724753837, 0.972970421, 0.302854293;0.814629185, 0.649884548, 0.394796474, 0.399394482, 0.178017387, 0.339332579, 0.144877044, 0.102702223, 0.718497546, 0.567790653, 0.757971393, 0.304278821, 0.260463218, 0.100065418, 0.988486505, 0.676934383, 0.360694105;0.0453608573, 0.246115669, 0.728874156, 0.175892097, 0.801240728, 0.502439597, 0.849997394, 0.00159542335, 0.349660805, 0.498534114, 0.544424088, 0.107700532, 0.612786479, 0.464879632, 0.86151129, 0.274085488, 0.657716509;0.0960156344, 0.754328799, 0.946693268, 0.843204976, 0.375786077, 0.592829901, 0.474940287, 0.288765441, 0.629586417, 0.512103859, 0.782732148, 0.0530442411, 0.604560719, 0.254532477, 0.696475134, 0.80533672, 0.507645956]
km_test = [2.66311095, 0.998868784, 0.978293829, 1.25840264, 1.80547985, 1.01513003, 0.85785708, 2.20709483, 1.82231526, 1.31579792, 0.749975031, 1.75240188, 1.13491583, 1.11871397, 2.1870713, 1.31646702, 0.737266369;3.10117479, 2.37053684, 3.22386117, 1.57062518, 2.36153456, 2.12432657, 2.89721104, 1.67985044, 2.74259391, 2.74169152, 2.13762186, 1.79572909, 3.22468016, 1.81733369, 3.23077563, 1.20415112, 2.54296058;1.36852037, 1.35759156, 2.77777793, 2.25331676, 3.25051671, 2.37567996, 2.58562404, 1.87784985, 3.03334862, 2.29256628, 1.65763901, 1.34328493, 2.91512601, 1.91792982, 2.81151803, 2.03864116, 2.13272711;2.09652889, 2.36402717, 2.14993788, 2.4714242, 2.50770797, 1.71818482, 1.92431278, 3.49252518, 2.14171897, 1.03523805, 1.54649695, 2.42298239, 2.27967189, 1.72984347, 2.28885624, 3.49819349, 1.23190318;3.86255966, 3.53397109, 2.78198713, 2.63643902, 3.55986659, 2.48048634, 4.19305536, 3.3014667, 2.60954373, 3.64539459, 1.86313566, 4.05148393, 3.22274009, 2.90948036, 1.28988351, 2.35484712, 2.86857898;1.84839962, 2.02207302, 1.75363249, 1.88613863, 1.03829363, 0.760119011, 2.02336432, 1.66170787, 1.9848999, 1.57983063, 0.940557399, 1.94822966, 1.89372196, 1.1779615, 1.95538745, 1.88458494, 1.14761305;2.99623398, 2.95140357, 2.35759272, 2.59063765, 1.88584684, 1.47067581, 1.63380775, 1.98978032, 3.21264441, 1.8346214, 1.80202045, 3.35525531, 2.73115476, 1.22921877, 2.19630511, 4.26931283, 1.65550388;1.62416543, 2.67689212, 1.39654682, 1.4197843, 1.64706353, 1.24376767, 1.26981615, 2.91421086, 1.78249289, 1.42269097, 1.71374646, 1.59495473, 1.20776017, 0.620936756, 2.6989772, 2.35320193, 1.3214446;1.06741358, 2.17343089, 2.20471432, 0.891497734, 1.54026448, 1.54990687, 2.37577758, 1.92587129, 1.58472246, 1.65070032, 1.2755565, 1.77181606, 2.53399717, 0.769743357, 2.11318387, 1.74681957, 2.32418163;2.13579037, 3.33214967, 2.98185746, 1.93159029, 1.93441932, 2.1179085, 2.8224596, 3.73914054, 1.48346206, 2.07097017, 1.9166643, 1.8181588, 3.01916321, 1.56860154, 2.32440051, 1.65985715, 2.53134946;2.16561623, 1.19855156, 0.900402823, 1.23259184, 1.91495872, 1.1273412, 1.67646591, 2.4641187, 1.73412332, 0.346668816, 0.393477516, 2.1508715, 1.29178443, 1.08339693, 1.12431159, 2.03324963, 0.44532538;2.8041106, 1.31394222, 3.33923814, 2.63882819, 3.31243585, 3.23056831, 2.70061278, 2.97907253, 3.08145584, 2.55167407, 2.12116037, 2.37856663, 3.64895856, 2.76511929, 3.62672488, 1.93839375, 2.91782006;2.23990247, 0.78816118, 0.913767155, 1.62716136, 2.24586653, 1.44690751, 1.6579046, 2.74353098, 1.73748989, 0.673583041, 0.241295128, 2.28652432, 1.32673331, 1.46882094, 1.01111904, 1.84379585, 0.540766553]
traindat = [0.237647629, 0.0584100077, 0.0252256721, 0.772557209, 0.728082346, 0.502987388, 0.709640741, 0.597553176, 0.718970516, 0.548809309, 0.472040552, 0.070587926, 0.459950614;0.320434673, 0.874704169, 0.517893009, 0.318035461, 0.431837482, 0.447975678, 0.589099194, 0.213923396, 0.90175492, 0.644874407, 0.645945585, 0.85694173, 0.548117546;0.196979986, 0.867267731, 0.580767859, 0.000660197094, 0.89277055, 0.532167789, 0.231852785, 0.826069503, 0.82077546, 0.677722302, 0.32355208, 0.00736405016, 0.0930591026;0.426949643, 0.520936471, 0.521816548, 0.44914082, 0.116945471, 0.557450281, 0.901296335, 0.471463836, 0.935837131, 0.597119402, 0.212608806, 0.820060087, 0.184152972;0.547263013, 0.324316086, 0.949500975, 0.159888275, 0.766903067, 0.464169584, 0.538579328, 0.141816648, 0.443435211, 0.106909611, 0.165978197, 0.965470633, 0.440684173;0.326312722, 0.184782651, 0.430428631, 0.900728303, 0.100951308, 0.0776521927, 0.946910946, 0.701053173, 0.563118253, 0.370045668, 0.865613857, 0.311643027, 0.531513917;0.451755145, 0.213340679, 0.645886951, 0.689764033, 0.0314995505, 0.772728487, 0.732833787, 0.896700956, 0.382952779, 0.0933191234, 0.733764754, 0.17144842, 0.473841517;0.474683094, 0.478775852, 0.496046484, 0.205300086, 0.000214442063, 0.330798525, 0.0284133884, 0.789781519, 0.851090231, 0.731277509, 0.286708213, 0.933634373, 0.332818418;0.190744861, 0.129934084, 0.805658435, 0.709407613, 0.911662267, 0.587120072, 0.0913291125, 0.128522461, 0.629600337, 0.994929146, 0.438754312, 0.950168562, 0.838490868;0.489599855, 0.00953023685, 0.116191522, 0.58490428, 0.56903033, 0.721767724, 0.987558845, 0.877308831, 0.281985162, 0.770616404, 0.377956562, 0.0942927116, 0.427355373;0.960108176, 0.75310023, 0.0637402514, 0.0204266992, 0.973134813, 0.197727131, 0.151462995, 0.253458299, 0.220714416, 0.00446705771, 0.745961529, 0.333820267, 0.672055256]
km_train = [0, 1.47703202, 1.96867035, 2.32409945, 2.35908112, 1.30581334, 2.04306515, 1.69952463, 2.0311249, 2.6690128, 0.989958714, 2.10275252, 0.81297953;1.47703202, 0, 1.94455378, 4.28382118, 2.94964618, 2.2936991, 3.69477237, 2.8141044, 1.91790891, 2.87785035, 2.07942748, 2.26948925, 2.40420402;1.96867035, 1.94455378, 0, 2.52398228, 3.36602817, 1.43700862, 2.91513947, 2.65530045, 1.44880607, 2.19305406, 2.19863106, 1.35654912, 1.84201924;2.32409945, 4.28382118, 2.52398228, 0, 3.88487896, 1.66569602, 1.48667694, 1.92307219, 2.24170687, 1.91081943, 1.40100669, 3.25278284, 1.28760213;2.35908112, 2.94964618, 3.36602817, 3.88487896, 0, 2.11311102, 3.7950646, 3.85477795, 2.9848558, 2.82693572, 2.5480406, 3.89316063, 1.91695993;1.30581334, 2.2936991, 1.43700862, 1.66569602, 2.11311102, 0, 1.66190662, 1.34530988, 1.27239203, 1.44624982, 1.49302194, 2.60448457, 1.29714489;2.04306515, 3.69477237, 2.91513947, 1.48667694, 3.7950646, 1.66190662, 0, 1.68475731, 2.18868182, 2.90707576, 1.79740805, 3.94391425, 2.17776813;1.69952463, 2.8141044, 2.65530045, 1.92307219, 3.85477795, 1.34530988, 1.68475731, 0, 1.6067039, 1.92455567, 1.43096753, 4.23479471, 2.2338488;2.0311249, 1.91790891, 1.44880607, 2.24170687, 2.9848558, 1.27239203, 2.18868182, 1.6067039, 0, 1.10158775, 1.67894267, 1.87214157, 1.75229662;2.6690128, 2.87785035, 2.19305406, 1.91081943, 2.82693572, 1.44624982, 2.90707576, 1.92455567, 1.10158775, 0, 2.29791463, 2.68075731, 2.08479676;0.989958714, 2.07942748, 2.19863106, 1.40100669, 2.5480406, 1.49302194, 1.79740805, 1.43096753, 1.67894267, 2.29791463, 0, 3.01993567, 0.533384091;2.10275252, 2.26948925, 1.35654912, 3.25278284, 3.89316063, 2.60448457, 3.94391425, 4.23479471, 1.87214157, 2.68075731, 3.01993567, 0, 1.84272973;0.81297953, 2.40420402, 1.84201924, 1.28760213, 1.91695993, 1.29714489, 2.17776813, 2.2338488, 1.75229662, 2.08479676, 0.533384091, 1.84272973, 0]
size_= 10 
