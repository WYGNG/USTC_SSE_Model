/**
 * A sample Java code demonstrating the use of lib/model.jar in Uppaal-4.1.19 distribution.
 * Use the following commands to compile and run:
 *
 *     javac -cp lib/model.jar ModelDemo.java
 *     java -cp uppaal.jar:lib/model.jar:. ModelDemo hardcoded
 *
 * ModelDemo will produce result.xml and generate a symbolic trace.
 * ModelDemo can also read an external model file (use Control+C to stop):
 *
 *     java -cp uppaal.jar:lib/model.jar:. ModelDemo demo/train-gate.xml
 *
 * @author Marius Mikucionis marius@cs.aau.dk
 */

import com.uppaal.engine.CannotEvaluateException;
import com.uppaal.engine.Engine;
import com.uppaal.engine.EngineException;
import com.uppaal.engine.Problem;
import com.uppaal.model.core2.Document;
import com.uppaal.model.core2.Edge;
import com.uppaal.model.core2.Location;
import com.uppaal.model.core2.Property;
import com.uppaal.model.core2.PrototypeDocument;
import com.uppaal.model.core2.Template;
import com.uppaal.model.system.SystemEdge;
import com.uppaal.model.system.SystemLocation;
import com.uppaal.model.system.SystemState;
import com.uppaal.model.system.concrete.ConcreteState;
import com.uppaal.model.system.concrete.ConcreteVariable;
import com.uppaal.model.system.symbolic.SymbolicState;
import com.uppaal.model.system.symbolic.SymbolicTransition;
import com.uppaal.model.system.UppaalSystem;
import java.math.BigDecimal;
import java.io.IOException;
import java.io.File;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

public class ModelDemo
{
    /**
     * Valid kinds of labels on locations.
     */
    public enum LKind {
        name, init, urgent, committed, invariant, exponentialrate, comments
    };
    /**
     * Valid kinds of labels on edges.
     */
    public enum EKind {
        select, guard, synchronisation, assignment, comments
    };
    /**
     * Sets a label on a location.
     * @param l the location on which the label is going to be attached
     * @param kind a kind of the label
     * @param value the label value (either boolean or String)
     * @param x the x coordinate of the label
     * @param y the y coordinate of the label
     */
    public static void setLabel(Location l, LKind kind, Object value, int x, int y) {
        l.setProperty(kind.name(), value);
        Property p = l.getProperty(kind.name());
        p.setProperty("x", x);
        p.setProperty("y", y);        
    }
    /**
     * Adds a location to a template.
     * @param t the template
     * @param name a name for the new location
     * @param x the x coordinate of the location
     * @param y the y coordinate of the location
     * @return the new location instance
     */
    public static Location addLocation(Template t, String name, int x, int y) {
        Location l = t.createLocation();
        t.insert(l, null);
        l.setProperty("x", x);
        l.setProperty("y", y);        
        setLabel(l, LKind.name, name, x, y-28);
        return l;
    }
    /**
     * Sets a label on an edge.
     * @param e the edge
     * @param kind the kind of the label
     * @param value the content of the label
     * @param x the x coordinate of the label
     * @param y the y coordinate of the label
     */
    public static void setLabel(Edge e, EKind kind, String value, int x, int y) {
        e.setProperty(kind.name(), value);
        Property p = e.getProperty(kind.name());
        p.setProperty("x", x);
        p.setProperty("y", y);
    }
    /**
     * Adds an edge to the template
     * @param t the template where the edge belongs
     * @param source the source location
     * @param target the target location
     * @param guard guard expression
     * @param sync synchronization expression 
     * @param update update expression
     * @return 
     */
    public static Edge addEdge(Template t, Location source, Location target,
            String guard, String sync, String update) 
    {
        Edge e = t.createEdge(); 
        t.insert(e, null);
        e.setSource(source);
        e.setTarget(target);
        int x = (source.getX()+target.getX())/2;
        int y = (source.getY()+target.getY())/2;
        if (guard != null) {
            setLabel(e, EKind.guard, guard, x-15, y-28);
        }
        if (sync != null) {
            setLabel(e, EKind.synchronisation, sync, x-15, y-14);
        }
        if (update != null) {
            setLabel(e, EKind.assignment, update, x-15, y);
        }
        return e;
    }
    
    public static void print(UppaalSystem sys, SymbolicState s) {
        System.out.print("(");
        for (SystemLocation l: s.getLocations()) {
            System.out.print(l.getName()+", ");
        }
	int val[] = s.getVariables();
	for (int i=0; i<sys.getNoOfVariables(); i++) {
	    System.out.print(sys.getVariableName(i)+"="+val[i]+", ");
	}
	List<String> constraints = new ArrayList<String>();
	s.getPolyhedron().getAllConstraints(constraints);
	for (String constraint : constraints) {
	    System.out.print(constraint+", ");
	}
        System.out.println(")");
    }
    /**
     * Locates the path to engine for different platforms.
     */
    public static String getEnginePath(){
	String os = System.getProperty("os.name");
	URL url = ClassLoader.getSystemResource("com/uppaal/engine/Engine.class");
	try {
	    url = new URL(url.getPath()); // strip jar scheme
	} catch (MalformedURLException ex) {
	    ex.printStackTrace(System.err);
	    System.exit(1);
	}
	File file = new File(url.getPath());
	while (file != null && !("model.jar!".equals(file.getName())))
	    file = file.getParentFile();
	if (file == null) {
	    System.err.println("Could not locate the Uppaal installation path.");
	    System.exit(1);
	}
	file = file.getParentFile(); // lib
	file = file.getParentFile(); // installation
	if ("Linux".equals(os)) {
	    file = new File(new File(file, "bin-Linux"), "server");
	} else {
	    file = new File(new File(file, "bin-Win32"), "server.exe");
	}
	return file.getPath();
    }

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        if (args.length<1) {
            System.out.println("This is a demo of Uppaal model.jar");
            System.out.println("Use one of the following arguments:");
            System.out.println("  hardcoded");
            System.out.println("  <URL>"); 
            System.out.println("  <path/file.xml>");
            System.exit(0);
        }
        Document doc = null;
        if ("hardcoded".equals(args[0])) {
            // Generate hardcoded model:
            // create a new Uppaal model with default properties:
            doc = new Document(new PrototypeDocument());
            // add global variables:
            doc.setProperty("declaration", "int v;\n\nclock x,y,z;");
            // add a TA template:
            Template t = doc.createTemplate(); doc.insert(t, null);
            t.setProperty("name", "Experiment");
            // the template has initial location:
            Location l0 = addLocation(t, "L0", 0, 0);
            l0.setProperty("init", true);
            // add another location to the right:
            Location l1 = addLocation(t, "L1", 150, 0);
            setLabel(l1, LKind.invariant, "x<=10", l1.getX()-7, l1.getY()+10);
            // add another location below to the right:
            Location l2 = addLocation(t, "L2", 150, 150);
            setLabel(l2, LKind.invariant, "y<=20", l2.getX()-7, l2.getY()+10);
            // add another location below:            
            Location l3 = addLocation(t, "L3", 0, 150);
            // add another location below:            
            Location lf = addLocation(t, "Final", -150, 150);
            // create an edge L0->L1 with an update
            Edge e = addEdge(t, l0, l1, null, null, "v=1,\nx=0");
            e.setProperty(EKind.comments.name(), "Execute L0->L1 with v=1");
            // create some more edges:
            addEdge(t, l1, l2, "x>=5", null, "v=2,\ny=0");
            addEdge(t, l2, l3, "y>=10", null, "v=3,\nz=0");
            addEdge(t, l3, l0, null, null, "v=4");
            addEdge(t, l3, lf, null, null, "v=5");
            // add system declaration:
            doc.setProperty("system", 
                    "Exp1=Experiment();\n"+
                    "Exp2=Experiment();\n\n"+
                    "system Exp1, Exp2;");
        } else {
            // load an external model:
            try {
                try {
                    // try URL scheme (useful to fetch from Internet):
                    doc = new PrototypeDocument().load(new URL(args[0]));
                } catch (MalformedURLException ex) {
                    // not URL, retry as it were a local filepath:
                    doc = new PrototypeDocument().load(new URL("file", null, args[0]));
                }
            } catch (IOException ex) {
                System.err.println(ex.getMessage());
                ex.printStackTrace(System.err);
                System.exit(1);
            }
        }
        // Some operations with the created model:
        try {
            // save the model into a file:
            doc.save(new File("result.xml"));
            // create a link to a local Uppaal process:
            Engine engine = new Engine();
	    engine.setServerPath(getEnginePath());
            engine.connect();
            // compile the model into system:
            ArrayList<Problem> problems = new ArrayList<Problem>();
            UppaalSystem system = engine.getSystem(doc, problems);
            if (!problems.isEmpty()) {
                boolean fatal = false;
                System.out.println("There are problems with the document:");
                for (Problem p : problems) {
                    System.out.println(p.toString());
                    if (!"warning".equals(p.getType())) { // ignore warnings
                        fatal = true;
                    }
                }
                if (fatal) {
                    System.exit(1);
                }
            }
            // compute the initial state:
            SymbolicState state = engine.getInitialState(system);
            while (state != null) {
                print(system, state);
                // compute the outgoing transitions with successors (including "deadlock"):
                ArrayList<SymbolicTransition> trans = engine.getTransitions(system, state);
                // select a random transition:
                SymbolicTransition tr = trans.get((int)Math.floor(Math.random()*trans.size()));
                if (tr.getSize()==0) { // transition without edges, something special:
                    System.out.println(tr.getEdgeDescription());
		    break;
                } else { // one or more edges involved:
                    System.out.print("(");
                    for (SystemEdge e: tr.getEdges()) {
                        System.out.print(e.getProcessName()+": "
                            + e.getEdge().getSource().getPropertyValue("name")
                            + " -> "
                            + e.getEdge().getTarget().getPropertyValue("name")+", ");
                    }
                    System.out.println(")");
                }
                state = tr.getTarget();
            }
	    engine.disconnect(); // terminate the engine process
	} catch (CannotEvaluateException ex) {
            ex.printStackTrace(System.err);
            System.exit(1);
        } catch (EngineException ex) {
            ex.printStackTrace(System.err);
            System.exit(1);
        } catch (IOException ex) {
            ex.printStackTrace(System.err);
            System.exit(1);
        }
    }
}
