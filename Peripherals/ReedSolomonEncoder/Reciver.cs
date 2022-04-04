using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ReedSolomonEncoder
{
    class Receiver
    {
        private int[] receivedCode = new int[15];
        private int[] recoveredCode = new int[15];
        private List<int> errorsPositions = new List<int>();

        public Receiver(int[] code)
        {
            this.receivedCode = GaluaField.DFT(code);

            Console.WriteLine("Received Code:");
            foreach (int res in receivedCode)
            {
                Console.WriteLine(res);
            }

            if (receivedCode[receivedCode.Length - 1] == 0 &&
                receivedCode[receivedCode.Length - 2] == 0 &&
                receivedCode[receivedCode.Length - 3] == 0 &&
                receivedCode[receivedCode.Length - 4] == 0)
            {
                this.recoveredCode = receivedCode;
            }
            else
            {
                int[,] ToeplitzMatrix = new int[3, 3] { { receivedCode[13],receivedCode[14],0},
                                                        { receivedCode[12],receivedCode[13],receivedCode[14]},
                                                        { receivedCode[11],receivedCode[12],receivedCode[13]}};
                int[] L = new int[3] { 1, 0, 0 };

                for (int i = 0; i < 16; i++)
                {
                    for (int j = 0; j < 16; j++)
                    {

                        int[] buffer = GaluaField.MulVectorMatrix(new int[3] { 1, j, i }, ToeplitzMatrix);
                        if (buffer[0] == 0 && buffer[1] == 0)
                        {
                            L[1] = j;
                            L[2] = i;
                            break;
                        }
                    }
                }

                //IDFT with error positions calculation
                for (int i = 0; i < 15; i++)
                {
                    int C = GaluaField.Pow(GaluaField.primitiveElement, i);

                    int[] buffer = new int[3];
                    for (int j = 0; j < L.Length; j++)
                    {
                        buffer[j] = GaluaField.Mul(L[j], GaluaField.Pow(C, j));
                    }
                    if (GaluaField.Add(buffer) == 0) errorsPositions.Add(i);
                }

                GaluaField.Normalize(L);

                int[] receiveCopy = new int[15];
                for(int i = 0; i<15; i++)
                {
                    receiveCopy[i] = receivedCode[i];
                }

                for (int i = 10; i >= 0; i--)
                {
                    for (int j = 0; j < 16; j++)
                    {
                        if (GaluaField.Add(GaluaField.Mul(L[2], j), GaluaField.Mul(L[1], receiveCopy[i + 1]), GaluaField.Mul(L[0], receiveCopy[i + 2])) == 0)
                        {
                            receiveCopy[i] = j;
                        }
                    }
                }

                int[] error = GaluaField.IDFT(receiveCopy);

                int[] codeWithoutError = new int[15];
                for (int i = 0; i < receiveCopy.Length; i++)
                {
                    codeWithoutError[i] = GaluaField.Add(code[i], error[i]);
                }

                recoveredCode = GaluaField.DFT(codeWithoutError);
            }
        }

        public int[] RecoveredCode
        {
            get
            {
                int[] result = new int[11];
                for (int i = 0; i < result.Length; i++)
                    result[i] = recoveredCode[i];
                return result;
            }
        }

        public int[] ReceivedCode
        {
            get
            {
                int[] result = new int[11];
                for (int i = 0; i < result.Length; i++)
                    result[i] = receivedCode[i];
                return result;
            }
        }

        public List<int> ErrorsPositions
        {
            get { return this.errorsPositions; }
        }
    }
}
