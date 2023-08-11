import React from 'react'

function Donation() {

    const handleDonation = ()=>{

    }
  return (
    <div className= 'bg-black  flex flex-row w-full h-screen'>
      
      <div className='w-2/4  bg-white flex justify-center items-center flex-col space-y-7'>
      <h1 className='text-center font-semibold  text-2xl'> Organization Name</h1>
   
        <form onSubmit={handleDonation} className='m-10 flex flex-col justify-center items-center space-y-8'>
         

         <label htmlFor='amount'> Amount</label>
         <input id = 'amount' type = 'number' className='border ring-0 ring-blue-200 bg-gray-200 p-7 rounded-sm '/>

         <button className='p-5 rounded-md bg-green-500 '> Save a Life</button>

     </form>


    
       


      </div>
      
      <div className='w-2/4 '>
        

      </div>
    </div>
  )
}

export default Donation
