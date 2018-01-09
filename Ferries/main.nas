
var main = func( root ) {
    
    # logger defines global instance "logging"
    io.load_nasal(root ~ "/Nasal/logger.nas","ferries");
    
    
    var dir = directory(root); # get directory
    files = subvec(dir, 2); # strips off the first two elements
    
    foreach (f;files) {
        io.load_nasal(root ~ "/Nasal/ferries/" ~ f,"ferries");
    }
    
    groundservices.root = root;
    groundservices.reinit();
    
    setlistener("/sim/signals/reinit", func() {
        #reinit also performs shutdown if required
        ferryservices.reinit();
    });
    
    setlistener("/sim/signals/exit", func() {
        #nothing to do
    });
    
    #TODO proper setup/cleanup as described in http://wiki.flightgear.org/Addons
    printlog("alert","Ferry addon initialized from path", root );       
}
