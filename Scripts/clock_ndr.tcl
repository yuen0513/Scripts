set CTS_NDR_MIN_ROUTING_LAYER	"metal4"
set CTS_NDR_MAX_ROUTING_LAYER	"metal5"
set CTS_LEAF_NDR_MIN_ROUTING_LAYER	"metal1"
set CTS_LEAF_NDR_MAX_ROUTING_LAYER	"metal6"
set CTS_NDR_RULE_NAME 		"cts_w2_s2_vlg"
set CTS_LEAF_NDR_RULE_NAME	"cts_w1_s2"

if {$CTS_NDR_RULE_NAME != ""} {
	remove_routing_rules $CTS_NDR_RULE_NAME > /dev/null

	create_routing_rule $CTS_NDR_RULE_NAME \
		-default_reference_rule \
		-widths { metal1 0.14 metal2 0.14 metal3 0.14 metal4 0.28 metal5 0.28 metal6 0.28} \
		-spacings { metal2 0.14 metal3 0.14 metal4 0.28 metal5 0.28 metal6 0.28} \
		-taper_distance 0.4 \
		-driver_taper_distance 0.4 
#		-cuts { \
#			{ VIA1 {V1LG 1} } \
#			{ VIA2 {V2LG 1} } \
#			{ VIA3 {V3LG 1} } \
#			{ VIA4 {V4LG 1} } \
#			{ VIA5 {V5LG 1} } \
#		}

	set_clock_routing_rules -rules $CTS_NDR_RULE_NAME \
		-min_routing_layer $CTS_NDR_MIN_ROUTING_LAYER \
		-max_routing_layer $CTS_NDR_MAX_ROUTING_LAYER

}

if {$CTS_LEAF_NDR_RULE_NAME != ""} {
	remove_routing_rules $CTS_LEAF_NDR_RULE_NAME > /dev/null

	create_routing_rule $CTS_LEAF_NDR_RULE_NAME \
		-default_reference_rule \
		-spacings { metal2 0.14 metal3 0.14 metal4 0.28 metal5 0.28 metal6 0.28} 

	set_clock_routing_rules -net_type sink -rules $CTS_LEAF_NDR_RULE_NAME \
		-min_routing_layer $CTS_LEAF_NDR_MIN_ROUTING_LAYER \
		-max_routing_layer $CTS_LEAF_NDR_MAX_ROUTING_LAYER
}
