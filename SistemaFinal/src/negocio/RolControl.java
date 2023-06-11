/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package negocio;

import datos.RolDAO;
import entidades.Rol;
import java.util.ArrayList;
import java.util.List;
import javax.swing.table.DefaultTableModel;

/**
 *
 * @author jerem
 */
public class RolControl {
    
    private final RolDAO DATOS;
    private Rol obj;
    private DefaultTableModel modeloTabla;
    private int registrosMostrados;

    public RolControl() {
        
        this.DATOS = new RolDAO();
        this.obj = new Rol();
        this.registrosMostrados = 0;
        
    }
    
    public DefaultTableModel listar(){
        List<Rol> lista = new ArrayList();
        lista.addAll(DATOS.listar());
        String[] titulos={"ID","Nombre","Descripcion"};
        this.modeloTabla = new DefaultTableModel(null,titulos);
       
        String[] registro = new String[3];
        registrosMostrados = 0;

        
        for (Rol item:lista ) {
            registro[0]=Integer.toString(item.getId());
            registro[1]=item.getNombre();
            registro[2]=item.getDescripcion();
            this.modeloTabla.addRow(registro);
            this.registrosMostrados = this.registrosMostrados +1;
                    
            
        }
        return modeloTabla;
        
    
}
    
    
     public int total (){
        return DATOS.total();
        
    }
    
    public int totalMostrados(){
        return registrosMostrados;
    }
}
