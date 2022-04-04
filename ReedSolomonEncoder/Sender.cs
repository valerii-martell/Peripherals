using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ReedSolomonEncoder
{
    class Sender
    {
        private int[] code = new int[15];

        public Sender(int[] informationSymbols)
        {
            for (int i = 0; i < informationSymbols.Length; i++)
            {
                this.code[i] = informationSymbols[i];
            }
            code[informationSymbols.Length] = 0;
            code[informationSymbols.Length + 1] = 0;
            code[informationSymbols.Length + 2] = 0;
            code[informationSymbols.Length + 3] = 0;
        }

        public int[] Code
        {
            get { return GaluaField.IDFT(this.code); }
        }
    }
}
