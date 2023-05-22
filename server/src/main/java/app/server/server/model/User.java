package app.server.server.model;

public class User {
    public String fName;
    public String lName;
    public String email;
    public String username;

    public User(String fn, String ln, String em, String un){
        this.fName = fn;
        this.lName = ln;
        this.email = em;
        this.username = un;
    }
}
