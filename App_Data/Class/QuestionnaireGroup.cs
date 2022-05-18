using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LSA
{
    public class QuestionnaireGroup
    {
        public int QnsGroupID { get; set; }
        public string Category { get; set; }
        public string Desc { get; set; }
        public string CreateBy { get; set; }
        public DateTime CreateDate { get; set; }
        public string AmendBy { get; set; }
        public DateTime AmendDate { get; set; }

        public QuestionnaireGroup()
        {

        } 
        
        public QuestionnaireGroup(int qnsgrpid, string category, string desc, string cBy, DateTime cDate, string aBy, DateTime aDate)
        {
            QnsGroupID = qnsgrpid;
            Category = category;
            Desc = desc;
            CreateBy = cBy;
            CreateDate = cDate;
            AmendBy = aBy;
            AmendDate = aDate;
        }
    }
}