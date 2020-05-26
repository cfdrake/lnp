Engine_Freejazz : CroneEngine {
  var <synth;
  
  *new { arg context, doneCallback;
    ^super.new(context, doneCallback);
  }
  
  alloc {
    synth = { arg out, x, y, z, amp;
      var hh = BPF.ar(WhiteNoise.ar(), 6200) * EnvGen.kr(Env.perc(y, x), Dust.ar(z));
    	var sn = (WhiteNoise.ar() + SinOsc.ar(120 + x)) * 0.5 * EnvGen.kr(Env.perc(0, y), Dust.ar(100));
    	var bd = SinOsc.ar(70 + y) * EnvGen.kr(Env.perc(0, 0.9), Dust.ar(z));
    
    	var final = Splay.ar(Fold.ar(Mix.ar([hh, sn, bd]), -0.8, 0.8));
      
      Out.ar(out, final);
    }.play(args: [\out, context.out_b], target: context.xg);
    
    this.addCommand("x", "f", { arg msg;
      synth.set(\x, msg[1]);
    });
    
    this.addCommand("y", "f", { arg msg;
      synth.set(\y, msg[1]);
    });
    
    this.addCommand("z", "f", { arg msg;
      synth.set(\z, msg[1]);
    });
  }
  
  free {
    synth.free;
  }
}