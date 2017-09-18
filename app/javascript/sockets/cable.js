import ActionCable from 'actioncable'

const WEBSOCKET_HOST = (process.env.NODE_ENV === 'production') ? 'wss://test_news.hometest.lan:5000/cable' : 'ws://test_news.hometest.lan:5000/cable'

export default function NewsSubscription({
	fnOnUpdate = () => {}
  }){
  this.cable = ActionCable.createConsumer(WEBSOCKET_HOST)

  this.subscribe = function (){
    this.channel = this.cable.subscriptions.create(
      { channel: 'NewsUpdatesChannel'},
      {
        // connected (){
        //   console.log('Updates channel is connected')
        // },
		// 
        // disconnected (){
        //   console.warn(`Updates channel was disconnected.`)
        // },
		// rejected (){
        //   console.warn('Updates channel was rejected!')
        // },
        received (data){
          // console.log('Updates channel - Received Data:', data)
          fnOnUpdate(data)
        },
      }
    )
  }
}