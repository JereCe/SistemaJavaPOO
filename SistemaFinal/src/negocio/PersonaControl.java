/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package negocio;


import datos.PersonaDAO;

import entidades.Persona;
 


import java.util.ArrayList;
import java.util.List;

import javax.swing.table.DefaultTableModel;

/**
 *
 * @author jerem
 */
public class PersonaControl {
    private final PersonaDAO DATOS;

    private Persona obj;
    private DefaultTableModel modeloTabla;
    private int registrosMostrados;
    
    
    public PersonaControl(){
        this.DATOS = new PersonaDAO();
        this.obj = new Persona();
        this.registrosMostrados = 0;
        
    }
    public DefaultTableModel listar(String Texto,int totalPorPagina,int numPagina){
        List<Persona> lista = new ArrayList();
        lista.addAll(DATOS.listar(Texto,totalPorPagina,numPagina));
        String[] titulos={"ID","Tipo Persona","Persona","Documento","NroDocumento","Direccion","Telefono","Email","Estado"};
        this.modeloTabla = new DefaultTableModel(null,titulos);
        String estado;
        String[] registro = new String[9];
        this.registrosMostrados = 0;

        
        for (Persona item:lista ) {
            if(item.isActivo()){
                estado ="Activo";
            }else{
                estado = "Inactivo";
            }
            registro[0]=Integer.toString(item.getId());
            registro[1]=item.getTipoPersona();
            registro[2]=item.getNombre();
            registro[3]=item.getTipoDocumento();
            registro[4]=item.getNumDocumento();
            registro[5]=item.getDireccion();
            registro[6]=item.getTelefono();
            registro[7]=item.getEmail();
            registro[8]=estado;
            this.modeloTabla.addRow(registro);
            this.registrosMostrados = this.registrosMostrados +1;
                    
            
        }
        return modeloTabla;
        
             
    }
    
     public DefaultTableModel listarTipo(String Texto,int totalPorPagina,int numPagina,String tipoPersona){
        List<Persona> lista = new ArrayList();
        lista.addAll(DATOS.listarTipo(Texto,totalPorPagina,numPagina,tipoPersona));
        String[] titulos={"ID","Tipo Persona","Persona","Documento","NroDocumento","Direccion","Telefono","Email","Estado"};
        this.modeloTabla = new DefaultTableModel(null,titulos);
        String estado;
        String[] registro = new String[9];
        this.registrosMostrados = 0;

        
        for (Persona item:lista ) {
            if(item.isActivo()){
                estado ="Activo";
            }else{
                estado = "Inactivo";
            }
            registro[0]=Integer.toString(item.getId());
            registro[1]=item.getTipoPersona();
            registro[2]=item.getNombre();
            registro[3]=item.getTipoDocumento();
            registro[4]=item.getNumDocumento();
            registro[5]=item.getDireccion();
            registro[6]=item.getTelefono();
            registro[7]=item.getEmail();
            registro[8]=estado;
            this.modeloTabla.addRow(registro);
            this.registrosMostrados = this.registrosMostrados +1;
                    
            
        }
        return modeloTabla;
        
             
    }

 
    public String insertar (String tipoPersona,String nombre, String tipoDocumento,String numDocumento,String direccion,String telefono,String email){
        if(DATOS.existe(nombre)){
            return "El registro ya existe";
        }else{
            obj.setTipoPersona(tipoPersona);
            obj.setNombre(nombre);
            obj.setTipoDocumento(tipoDocumento);
            obj.setNumDocumento(numDocumento);
            obj.setDireccion(direccion);
            obj.setTelefono(telefono);
            obj.setEmail(email);
            
            
            if(DATOS.insertar(obj)){
                return "OK";
            }else{
                return "Error en el registro";
            }
            
        }
        
        
    }
           
    
    public String actualizar (int id,String tipoPersona,String nombre,String nombreAnt,String tipoDocumento, String numDocumento,String direccion,String telefono,String email){
        if(nombre.equals(nombreAnt)){
            obj.setId(id);
            obj.setTipoPersona(tipoPersona);
            obj.setNombre(nombre);
            obj.setTipoDocumento(tipoDocumento);
            obj.setNumDocumento(numDocumento);
            obj.setDireccion(direccion);
            obj.setTelefono(telefono);
            obj.setEmail(email);
            
            if(DATOS.actualizar(obj)){
                return "OK";
            }
            else{
                return "Error en la actualizacion";
            }
            
        }else{
            if(DATOS.existe(email)){
                return"El registro ya existe";
            }else{
            
                obj.setId(id);
                obj.setTipoPersona(tipoPersona);
                obj.setNombre(nombre);
                obj.setTipoDocumento(tipoDocumento);
                obj.setNumDocumento(numDocumento);
                obj.setDireccion(direccion);
                obj.setTelefono(telefono);
                obj.setEmail(email);
                
                if(DATOS.actualizar(obj)){
                    return "OK";
                }else{
                    return "Error en la actualizacion";            
                }
                          
            }
           
        }                
        
    }
    
    public String desactivar (int id){
        if(DATOS.desactivar(id)){
            return"OK";
        }else{
            return "No se puede desactivar el registro";
        }
        
        
        
    }
    
    public String activar (int id){
        if(DATOS.activar(id)){
            return"OK";
        }else{
            return "No se puede activar el registro";
        }
        
    }
    
    public int total (){
        return DATOS.total();
        
    }
    
    public int totalMostrados(){
        return registrosMostrados;
    }
    
    
    
    
    
}
