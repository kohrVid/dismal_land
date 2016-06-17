locations = [{:id=>1, :name=>"The Galleries", :description=>"Dismaland boasts three large galleries which together comprise the finest collection of contemporary art ever assembled in a North Somerset seaside town.", :directions=>{:w=>23, :e=>22}},
  {:id=>2, :name=>"Model Village", :description=>"Jimmy Cauty's hand crafted miniature world will delight and amaze (and potentially cause seizures in persons sensitive to strobe lighting).", :directions=>{:e=>23}},
  {:id=>3, :name=>"Cinderella's Castle", :description=>"Step inside the fairytale and see how it feels to be a real princess. Souvenir photos available.", :directions=>{:w=>25}},
  {:id=>4, :name=>"Guerilla Island", :description=>"Features a bus-mounted museum, library, gallery of guerilla art, Comrades Advice Bureau and workshops in how to hack billboards.", :directions=>{:s=>27, :se=>5}},
  {:id=>5, :name=>"Ben Long", :description=>"... has constructed a stallion entirely from used scaffolding.", :directions=>{:nw=>4, :sw=>27, :ne=>7, :e=>6}},
  {:id=>6, :name=>"Water Cannon Creek", :description=>"An armour plated riot control vehicle built to serve on the streets of Northern Ireland. Equipped with sniper posts, grenade launchers and now – a children's slide.", :directions=>{:w=>5, :n=>7, :ne=>8}},
  {:id=>7, :name=>"Mini Gulf", :description=>"An oil caliphate themed crazy golf course made from the hockey pitch at Cheltenham Ladies college.", :directions=>{:sw=>5, :w=>4, :e=>8, :s=>6}},
  {:id=>8, :name=>"Giant Pin Wheel", :description=>"Commissioned by Banksy to power the entire site, it turns out this ecological marvel has trouble charging more than two mobile phones at once.", :directions=>{:w=>7, :e=>9}},
  {:id=>9, :name=>"Kids Enclosure", :description=>"Strictly for the little ones – an area that combines soft play and loan shop.", :directions=>{:w=>8, :e=>28, :se=>10}},
  {:id=>10, :name=>"Punch and Julie", :description=>"The infamous Julie Burchill has given this seaside staple a good kicking. Now includes references to Jimmy Saville and Fifty Shades of Grey.", :directions=>{:n=>28, :nw=>9, :e=>11, :se=>12}},
  {:id=>11, :name=>"Puppets", :description=>"A puppet revue show constructed entirely from the contents of Hackney skips – it's ‘Fly Tip Theatre' by Paul Insect and Bast. Self operated.", :directions=>{:w=>10, :nw=>28, :sw=>12, :s=>21}},
  {:id=>12, :name=>"Jeffrey Archer Memorial Fire Pit", :description=>"Warm yourself around an authentic real open fire ceremonially lit each day by burning one of the famed local perjurer's novels.", :directions=>{:n=>10, :ne=>11, :e=>21, :s=>13, :sw=>3}},
  {:id=>13, :name=>"Portrait Artist", :description=>"Nettie Wakefield renders your likeness in an exquisite pencil drawing, but only the back of your head. Surprisingly revealing.", :directions=>{:s=>22, :n=>12, :w=>3, :sw=>14, :nw=>12, :e=>21}},
  {:id=>14, :name=>"Picnic Area", :description=>"The humble picnic table proves a rich source of artistic ammunition for American furniture twerker Michael Beitz.", :directions=>{:sw=>24, :se=>22, :ne=>13, :nw=>3, :w=>17}},
  {:id=>15, :name=>"Cinema", :description=>"Truck-mounted outdoor screen playing a rolling program of short films day and night. Cushions not provided.", :directions=>{:e=>17, :se=>18, :nw=>25}},
  {:id=>16, :name=>"Circus Tent", :description=>"A gothic sculpture park in a tiny big top tent.", :directions=>{:s=>23, :e=>24, :n=>18}},
  {:id=>17, :name=>"Amusements Area", :description=>"Win big prizes on hook-a-duck and the shooting gallery. Knock over an anvil in David Shrigley's game of skill and cunning.", :directions=>{:sw=>18, :s=>24, :e=>14, :w=>15}},
  {:id=>18, :name=>"Big Rig Jig", :description=>"A masterpiece of post-industrial assemblage art – it's two juggernauts performing ballet by Mike Ross.", :directions=>{:s=>16, :se=>24, :e=>14, :ne=>17, :nw=>15, :sw=>23}},
  {:id=>19, :name=>"Parking Lot", :description=>"", :directions=>{:w=>20}},
  {:id=>20, :name=>"Security check", :description=>"Do not smile", :directions=>{:w=>13}},
  {:id=>21, :name=>"Exit through the gift shop", :description=>"", :directions=>{:e=>19}},
  {:id=>22, :name=>"Death Dance and Smiley", :description=>"", :directions=>{:w=>1, :n=>13}},
  {:id=>23, :name=>"Hallway", :description=>"", :directions=>{:n=>16, :e=>1, :w=>2}},
  {:id=>24, :name=>"Migrant Boats", :description=>"Navigate the high seas with Banksy's Mediterranean boat ride.", :directions=>{:n=>17, :ne=>14, :w=>16, :nw=>18}},
  {:id=>25, :name=>"Toilet Paper Tables", :description=>"", :directions=>{:se=>15, :n=>26}},
  {:id=>26, :name=>"Dolphin Toilet Bowl", :description=>"", :directions=>{:s=>25, :n=>4, :ne=>27}},
  {:id=>27, :name=>"Ferris Weel", :description=>"Staff operating this ride tell patrons, &quot;No sweets in line!&quot; and a very dry, &quot;Have. Fun.&quot;", :directions=>{:sw=>26, :n=>4, :ne=>5}},
  {:id=>28, :name=>"Food Area", :description=>"", :directions=>{:w=>9, :s=>10, :se=>11}}]

locations.each do|loc| 
                new_loc = Location.create(id: loc[:id], name: loc[:name], description: loc[:description]);
                loc[:directions].each do |k,v| 
                        Direction.create(location_id: new_loc.id, destination_id: v, direction: k)
                end
        end
