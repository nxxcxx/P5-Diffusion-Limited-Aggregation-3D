import peasy.*;
import toxi.geom.*;

PeasyCam cam;
int FRAME_RATE;

ArrayList<Particle> allP;

void setup() {
	size(600, 600, P3D); 
	smooth(16);
	initPeasyCam();

	allP = new ArrayList<Particle>();

	for (int i = 0; i < 100; ++i) {
		Vec3D rndVec = Vec3D.randomVector().scaleSelf(random(5, 20));
		Particle p = new Particle(rndVec);
		allP.add(p);
	}

	// initial growth 
	for (int i = 0; i < 5000; ++i) {
		Vec3D rndVec = Vec3D.randomVector().scaleSelf(random(100, 1000));
		Particle p = new Particle(rndVec);
		allP.add(p);
	}

	// sphere mode
	// noStroke();
	// fill(255);
	// sphereDetail(8);

	// stroke mode
	stroke(255, 162);


} // end of setup

void draw() {
	background(14, 14, 15);
	displayHUD();
	displayVisualGuide();
	//
	// ambientLight(50, 50, 80);
	// directionalLight(126, 126, 126, 1, -0.25, 0);
	// directionalLight(126, 126, 126, -1, 1, 0);

	for (int i = 0; i < allP.size(); ++i) {
		Particle p = allP.get(i);
		p.render();
	}

} // end of draw

//***************************************** TO DO: record pos instead of draw a sphere and use data to grow stuff!

class Particle {

	Vec3D pos;
	float rad;	// size

	Particle(Vec3D pos) {
		this.pos = pos;
		rad = random(1, 4);
		initParticle();
	}

	void render() {
		pushMatrix();
		translate(pos.x, pos.y, pos.z);
		// sohere mode
		// sphere(rad);

		// stroke mode
		strokeWeight(rad);
		point(0, 0, 0);
		popMatrix();
	}

	void initParticle() {
		if (allP.size() < 100) // if this is first x particle then return
			return;

		int index = 0;
		float distance = 999999;
		for (int i = 0; i < allP.size(); i++) {
			Particle otherP = allP.get(i);
			float dstBetween = otherP.pos.distanceTo(pos);
			if (dstBetween < distance) {
				index = i;
				distance = dstBetween;
			}
		}

		Particle nearP = allP.get(index);
		Vec3D np = nearP.pos.copy();	// position of particle to stick to
		Vec3D dirVec = pos.sub(np);		// directional vector
		dirVec.normalize();
		
		// caculate vector for spacing between particles (if not calculate this particle will be position at the same place)
		Vec3D radVec = dirVec.copy();
		float radius = (rad + nearP.rad) * 0.7;	// adjust margin here
		radVec.scaleSelf(radius);

		dirVec.addSelf(np);
		dirVec.addSelf(radVec);

		pos = dirVec;

	}

}
