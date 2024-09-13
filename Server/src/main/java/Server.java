import com.google.gson.Gson;

import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.ArrayList;
import java.util.List;

public class Server {
    public static void main(String[] args) throws Exception {

        List<Task> tasks = new ArrayList();
        tasks.add(new Task("Hang out with your friends", true));
        tasks.add(new Task("Do your hw", false));
        tasks.add(new Task("Hello world", false));
        tasks.add(new Task("Do not forget record your video", false));
        tasks.add(new Task("Study more about json", true));
        tasks.add(new Task("Do the first phase of project", true));
        tasks.add(new Task("Read the last chapter of your book", false));


        System.out.println("Welcome to the server");
        ServerSocket serverSocket = new ServerSocket(8080);
        while (true) {
            System.out.println("waiting for client...");
            Socket socket = serverSocket.accept();
            new ClientHandler(socket, tasks).start();
        }
    }
}

class ClientHandler extends Thread {
    private List<Task> tasks;
    private Socket socket;
    private DataOutputStream dos;
    private DataInputStream dis;

    public ClientHandler(Socket socket, List<Task> tasks) throws IOException {
        this.socket = socket;
        this.tasks = tasks;
        dos = new DataOutputStream(socket.getOutputStream());
        dis = new DataInputStream(socket.getInputStream());
    }

    @Override
    public void run(){
        try{
            System.out.println("Listening the command");
            String command = dis.readUTF();
            if(command.equals("getTasks")){
                System.out.println("The command is received");

                Gson gson = new Gson();
                String jsonTasks = gson.toJson(tasks);
                dos.writeUTF(jsonTasks);

                System.out.println("The data has just sent");

            } else{
                System.out.println("404, not found");
            }

            dos.flush();
            dis.close();
            dos.close();
            socket.close();

        } catch (Exception e){
            e.printStackTrace();
        }
    }
}

class Task {
    String title;
    boolean done;
    public Task(String title, boolean done) {
        this.title = title;
        this.done = done;
    }
}