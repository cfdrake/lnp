Engine_TwoCan : CroneEngine {
  var pg;
  var voices;
  
  *new { arg context, doneCallback;
    ^super.new(context, doneCallback);
  }
  
  alloc {
    SynthDef("TwoCan", { |out, synth, freq, timbre, chaos, amp, amp_lag, pan|
      var chaos_lagged = Lag.kr(chaos, 0.3);
      var timbre_lagged = Lag.kr(timbre, 0.3);
      
      var dust = Dust.kr(chaos_lagged);
      
      var tri = LFTri.ar(freq + (chaos_lagged *dust), timbre_lagged);
      var sq = Pulse.ar(freq + (chaos_lagged *dust), timbre_lagged / 4);
      var fb = SinOscFB.ar(freq + (chaos_lagged *dust), timbre_lagged);
      var osc = Select.ar(synth, [tri, sq, fb]);
      
      Out.ar(out, Pan2.ar(osc * Lag.kr(amp, amp_lag), pan))
    }).add;
    
    pg = ParGroup.tail(context.xg);
    voices = Array.fill(16, { Synth("TwoCan", [\out, context.out_b], target:pg) });
    
    this.addCommand("synth", "ii", { arg msg;
      var i = msg[1] - 1;
      var val = msg[2];
      
      voices[i].set(\synth, val)
    });
    
    this.addCommand("freq", "if", { arg msg;
      var i = msg[1] - 1;
      var val = msg[2];
      
      voices[i].set(\freq, val)
    });
    
    this.addCommand("timbre", "if", { arg msg;
      var i = msg[1] - 1;
      var val = msg[2];
      
      voices[i].set(\timbre, val)
    });
    
    this.addCommand("chaos", "if", { arg msg;
      var i = msg[1] - 1;
      var val = msg[2];
      
      voices[i].set(\chaos, val)
    });
    
    this.addCommand("amp", "if", { arg msg;
      var i = msg[1] - 1;
      var val = msg[2];
      
      voices[i].set(\amp, val)
    });
    
    this.addCommand("amp_lag", "if", { arg msg;
      var i = msg[1] - 1;
      var val = msg[2];
      
      voices[i].set(\amp_lag, val)
    });
    
    this.addCommand("pan", "if", { arg msg;
      var i = msg[1] - 1;
      var val = msg[2];
      
      voices[i].set(\pan, val)
    });
  }
  
  free {
    pg.free;
    voices.free;
  }
}