geneatree
=========

Ruby on Rails final project for TAP.

This is a small family tree app, right now only featuring the ability to add people's names. It uses the Dagre and D3 javascript libraries to create the tree using a directed graph.

In order to keep the trees from becoming too complex (which results in a lot of ugly intersecting lines all over the place), you can right now only add the ancestors, descendents, and children of ancestors and descendents of the first person added to the tree. This means no cousins, so this is a limitation I'd like to get around.