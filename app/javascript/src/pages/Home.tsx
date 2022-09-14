import { Button, Text, Grid } from '@nextui-org/react'
import { ArrowIcon } from '../components/Icons/ArrowIcon'
import { useNavigate } from 'react-router-dom';
import React from 'react';

const Home = () => {
  const navigate = useNavigate();
  return (
    <header>
      <section className="py-10 sm:py-16 lg:py-24">
        <div className="px-4 mx-auto max-w-7xl sm:px-6 lg:px-8">
          <div className="grid items-center grid-cols-1 gap-12 lg:grid-cols-2">
            <div>
              <Text className="text-base font-semibold tracking-wider">
                UN SERVICIO DE ELIZA ASESORES
              </Text>
              <Text
                className="mt-4 text-5xl font-bold text-black lg:mt-8 sm:text-7xl  xl:text-8xl"
                css={{
                  textGradient: '45deg, $yellow600 -20%, $red600 100%',
                }}
              >
                RENTA.eusa
              </Text>
              <Text className="mt-4 text-base text-black lg:mt-8 sm:text-xl">
                Tu declaración de la renta rápida y sencilla. En Vitoria Gasteiz.
              </Text>

              <Grid.Container gap={2} justify="center">
                  <Button
                    rounded
                    bordered
                    flat
                    className="px-6 py-4 mt-8"
                    color="warning"
                    size={'lg'}
                    auto
                    onPress={() => navigate('/calculator')}
                    iconRight={<ArrowIcon />}
                  >
                    Calcula tu precio
                  </Button>
              </Grid.Container>

              <Text className="mt-5 text-center">¿Necesitas ayuda?</Text>
            </div>

            <div>
            </div>
          </div>
        </div>
      </section>
    </header>
    
  )
}

export default Home