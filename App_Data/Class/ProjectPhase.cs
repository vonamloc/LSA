using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

public class ProjectPhase
{
    public int ProjPhaseID { get; set; }
    public DateTime StartDate { get; set; }
    public DateTime EndDate { get; set; }
    public string ProjectLead { get; set; }
    public string Member2 { get; set; }
    public string Member3 { get; set; }
    public string Member4 { get; set; }
    public string ProjectSupervisor { get; set; }
    public string CreateBy { get; set; }
    public DateTime CreateDate { get; set; }
    public string AmendBy { get; set; }
    public DateTime AmendDate { get; set; }

    public ProjectPhase()
    {

    }

    public ProjectPhase(int projphaseid, DateTime startdate, DateTime enddate, string projlead, string m2, string m3, string m4, string projsup, string cBy, DateTime cDate, string aBy, DateTime aDate)
    {
        ProjPhaseID = projphaseid;
        StartDate = startdate;
        EndDate = enddate;
        ProjectLead = projlead;
        Member2 = m2;
        Member3 = m3;
        Member4 = m4;
        ProjectSupervisor = projsup;
        CreateBy = cBy;
        CreateDate = cDate;
        AmendBy = aBy;
        AmendDate = aDate;
    }

}
