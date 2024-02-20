public with sharing class AccContact {
    
    public list<contact> conlst { get; set; }
    public list<account> accconts1 { get; set; }
    
    public PageReference selacc() {
        string getid=apexpages.currentpage().getparameters().get('conlst');
        accconts1=[select id,name, (select name from Opportunities ) from account where id=:getid ];
        system.debug(accconts1);
        return null;
    }
    
    
    public List<Account> acclst { get; set; }
    public  AccContact (){
        acclst=[select id,name  from account ];
        system.debug(acclst);
        
    }
}