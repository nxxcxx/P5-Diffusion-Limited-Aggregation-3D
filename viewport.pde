
double[] defaultCam = {0.5, 0, 0, 1000};
boolean enableAxis = false,
enableGrid = false;

void keyPressed() {
	if( key == 'q' || key == 'Q') {
		cam.setRotations(defaultCam[0], defaultCam[1], defaultCam[2]);
		cam.lookAt(0, 0, 0);
		cam.setDistance(defaultCam[3]);
	}
	else if( key == 'a' || key == 'A') {
		enableAxis = !enableAxis;
	}
	else if( key == 's' || key == 'S') {
		enableGrid = !enableGrid;
	}
	else if( key == 'e' || key == 'E') {
		exit();
	}

	if( keyCode == UP ) {
		for (int i = 0; i < 500; ++i) {
			Vec3D rndVec = Vec3D.randomVector().scaleSelf(random(100, 1000));
			Particle p = new Particle(rndVec);
			allP.add(p);
		}
	}

	if( keyCode == DOWN ) {
		for (int i = 0; i < 100; i++) {
			int index = allP.size()-1;
			if (index < 1) return;
			allP.remove(index);
		}
	}
}

void mouseClicked() {
// println(cam.getRotations()); 
}


void initPeasyCam() {
	cam = new PeasyCam(this, defaultCam[3]);
	cam.setMinimumDistance(0.00001);
	cam.setMaximumDistance(999999999);
	cam.setRotations(defaultCam[0], defaultCam[1], defaultCam[2]);
	cam.lookAt(0, 0, 0);
	// set clipping distance
	float cameraZ = ((height/2.0) / tan(PI*60.0/360.0));
	perspective(PI/3.0, (float) width/height, cameraZ/100.0, cameraZ*100.0);
}

void displayHUD() {
	cam.beginHUD();
	fill(255);
	textAlign(LEFT);
	if (frameCount%30 == 0) FRAME_RATE = (int) frameRate;
	text(FRAME_RATE, 5, 15);
	cam.endHUD();
}

void displayVisualGuide() {
	//// world AXIS
	if (enableAxis) {
		pushStyle();
		noFill();
		strokeWeight(1);
		stroke(0, 255, 0, 128);
		line(0,0,0, 0, 80, 0); // y
		stroke(255, 0, 0, 128);
		line(0,0,0, 80, 0, 0);  // x
		stroke(0, 0, 255, 128);
		line(0,0,0, 0, 0, 80);  // z
		stroke(255,50);
		box(10);
		popStyle();
	}
	//// world GRID
	if (enableGrid) {
		pushStyle();
		stroke(255,80);
		strokeWeight(1);
		for (int i = 0; i < 10; i++) {
			int spc = i*50;
			pushMatrix();
			translate(-450/2, 0, -450/2);
			line(spc,0,0, spc, 0, 450);  // z
			line(0,0,spc, 450, 0, spc);  // x
			popMatrix();
		}
		popStyle();
	}
}

