Engine_Crowl : CroneEngine {
  var <synth;
  
  *new { arg context, doneCallback;
    ^super.new(context, doneCallback);
  }
  
  alloc {
    synth = { arg out, x, y, amp;
      var p = Pulse.ar(Dust.ar(10)*100 + x);
      var p3 = SinOsc.ar(y);
      var p2 = Pulse.ar(p * x, mul: p3) * 0.5;
      var p4 = Pulse.ar(Pulse.kr(y, mul: 300, add: 300)) * 0.5;
      
      var final = Splay.ar(Fold.ar(p2 + p4, -0.5, 0.5)) * amp;
      
      Out.ar(out, final);
    }.play(args: [\out, context.out_b], target: context.xg);
    
    this.addCommand("x", "f", { arg msg;
      synth.set(\x, msg[1]);
    });
    
    this.addCommand("y", "f", { arg msg;
      synth.set(\y, msg[1]);
    });
    
    this.addCommand("amp", "f", { arg msg;
      synth.set(\amp, msg[1]);
    });
  }
  
  free {
    synth.free;
  }
}