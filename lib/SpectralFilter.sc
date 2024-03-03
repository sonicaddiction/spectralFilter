Engine_SpectralFilter : CroneEngine {

  var <synth;
  var params;

  *new { arg context, doneCallback;
    ^super.new(context, doneCallback);
  }

  alloc {
    SynthDef(\SpectralFilter, {
      arg out, a0=0.5, a1=0.5, a2=0.5, a3=0.5, a4=0.5, a5=0.5, a6=0.5, a7=0.5, a8=0.5, a9=0.5, a10=0.5, a11=0.5, a12=0.5, a13=0.5, a14=0.5, a15=0.5, rq=0.1, amp=0.5;
      var sig = SoundIn.ar([0,1]);
      var filtered = [
				LPF.ar(sig, 100, a0),
				BPF.ar(sig, 150, rq, a1),
				BPF.ar(sig, 250, rq, a2),
				BPF.ar(sig, 350, rq, a3),
				BPF.ar(sig, 500, rq, a4),
				BPF.ar(sig, 630, rq, a5),
				BPF.ar(sig, 800, rq, a6),
				BPF.ar(sig, 1000, rq, a7),
				BPF.ar(sig, 1300, rq, a8),
				BPF.ar(sig, 1600, rq, a9),
				BPF.ar(sig, 2000, rq, a10),
				BPF.ar(sig, 2600, rq, a11),
				BPF.ar(sig, 3500, rq, a12),
				BPF.ar(sig, 5000, rq, a13),
				BPF.ar(sig, 8000, rq, a14),
				HPF.ar(sig, 10000, a15)
      ];
      sig = Mix(filtered) * amp;
      Out.ar(out, sig);
    }).add;

    context.server.sync;

    synth = Synth.new(\SpectralFilter, [
      \out, context.out_b.index,
    ],
    context.xg);

    this.addCommand("a0", "f", {|msg|
      synth.set("a0", msg[1]);
    });
    this.addCommand("a1", "f", {|msg|
      synth.set("a1", msg[1]);
    });
    this.addCommand("a2", "f", {|msg|
      synth.set("a2", msg[1]);
    });
    this.addCommand("a3", "f", {|msg|
      synth.set("a3", msg[1]);
    });
    this.addCommand("a4", "f", {|msg|
      synth.set("a4", msg[1]);
    });
    this.addCommand("a5", "f", {|msg|
      synth.set("a5", msg[1]);
    });
    this.addCommand("a6", "f", {|msg|
      synth.set("a6", msg[1]);
    });
    this.addCommand("a7", "f", {|msg|
      synth.set("a7", msg[1]);
    });
    this.addCommand("a8", "f", {|msg|
      synth.set("a8", msg[1]);
    });
    this.addCommand("a9", "f", {|msg|
      synth.set("a9", msg[1]);
    });
    this.addCommand("a10", "f", {|msg|
      synth.set("a10", msg[1]);
    });
    this.addCommand("a11", "f", {|msg|
      synth.set("a11", msg[1]);
    });
    this.addCommand("a12", "f", {|msg|
      synth.set("a12", msg[1]);
    });
    this.addCommand("a13", "f", {|msg|
      synth.set("a13", msg[1]);
    });
    this.addCommand("a14", "f", {|msg|
      synth.set("a14", msg[1]);
    });
    this.addCommand("a15", "f", {|msg|
      synth.set("a15", msg[1]);
    });
    this.addCommand("rq", "f", {|msg|
      synth.set("rq", msg[1]);
    });
    this.addCommand("amp", "f", {|msg|
      synth.set("amp", msg[1]);
    });
	}

  free {
    synth.free;
  }
}
