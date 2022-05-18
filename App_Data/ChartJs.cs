using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LSA
{
    public class ChartJs
    {
        //This class serves as a purpose to initalise a basic chart using the minimum parameters required. Objects of this class will be converted into JSON on server and sent to client as a hidden field value.
        //Any additional chart properties should be set in the front-end Typescript
        //This value will then be converted back to JSON Object in Javascript so that is accesible by the ChartJs API

        public List<string> Labels { get; set; }
        public List<Dataset> Datasets { get; set; }

        public class Dataset
        {
            public string Label { get; set; }
            public List<float> Data { get; set; }
        }
    }

    public class Hierarchical_ChartJs
    {
        public List<HierarchicalChartLabel> Labels { get; set; }
        public List<Dataset> Datasets { get; set; }

        public class Dataset
        {
            public List<HierarchicalChartData> Tree { get; set; }
        }

        public class HierarchicalChartLabel
        {
            public string Label { get; set; }
            public bool Expand { get; set; }
            public List<object> Children { get; set; }
            public HierarchicalChartLabel()
            {

            }
        }

        public class HierarchicalChartData
        {
            public double Value { get; set; }
            public List<object> Children { get; set; }
            public HierarchicalChartData()
            {

            }
        }
    }
}