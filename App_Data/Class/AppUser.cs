using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

public class AppUser
{
    public string LoginID { get; set; }
    public string Email { get; set; }
    public string PasswordHash { get; set; }
    public string PasswordSalt { get; set; }
    public string IV { get; set; }
    public string Key { get; set; }
    public string UsrName { get; set; }
    public string UsrShtName { get; set; }
    public string UsrType { get; set; }
    public string UsrRole { get; set; }
    public string UsrStatus { get; set; }
    public string LockStatus { get; set; }
    public DateTime LockUntil { get; set; }
    public string AccessRgt { get; set; }
    public string AccessRgtGrp { get; set; }
    public DateTime LastLogin { get; set; }
    public DateTime LastPwdSet { get; set; }
    public string CreateBy { get; set; }
    public DateTime CreateDate { get; set; }
    public string AmendBy { get; set; }
    public DateTime AmendDate { get; set; }

    public AppUser()
    {

    }

    public AppUser(string loginid, string email, string pwdhash, string pwdsalt, string iv, string key, string usrname, string usrshtname, string usrtype, string usrrole, string usrstatus, string lockstatus,DateTime lockuntil, string accessrgt, string accessrgtgrp, DateTime lastlogin, DateTime lastpwdset, string cBy, DateTime cDate, string aBy, DateTime aDate)
    {
        LoginID = loginid;
        Email = email;
        PasswordHash = pwdhash;
        PasswordSalt = pwdsalt;
        IV = iv;
        Key = key;
        UsrName = usrname;
        UsrShtName = usrshtname;
        UsrType = usrtype;
        UsrRole = usrrole;
        UsrStatus = usrstatus;
        LockStatus = lockstatus;
        LockUntil = lockuntil;
        AccessRgt = accessrgt;
        AccessRgtGrp = accessrgtgrp;
        LastLogin = lastlogin;
        LastPwdSet = lastpwdset;
        CreateBy = cBy;
        CreateDate = cDate;
        AmendBy = aBy;
        AmendDate = aDate;
    }
}
