import { Button, Text } from '@nextui-org/react'
import axios from 'axios'
import React, { useEffect } from 'react'
import { Outlet } from 'react-router-dom'
import { useAppDispatch } from '../storage/hooks'
import { loadTaxIncomes } from '../storage/taxIncomeSlice'

function TaxIncomePage() {

  const dispatch = useAppDispatch();

  useEffect(() => {
    dispatch(loadTaxIncomes())
  })

  return (
    <React.Fragment>
      <header>
        <section className="py-5 ">
          <div className="px-4 mx-auto max-w-7xl sm:px-6 lg:px-8">
            <div>
              <Text className="text-base font-semibold tracking-wider">
                UN SERVICIO DE ELIZA ASESORES
              </Text>
              <Text
                className="text-5xl font-bold text-black sm:text-7xl  xl:text-8xl"
                css={{
                  textGradient: '45deg, $blue600 -20%, $pink600 50%',
                }}
              >
                Tu declaración
              </Text>
            </div>
          </div>
        </section>
      </header>
      <main className="px-4 mx-auto max-w-7xl sm:px-6 lg:px-8">
        <Outlet/>
      </main>
    </React.Fragment>
  )
}

export default TaxIncomePage
