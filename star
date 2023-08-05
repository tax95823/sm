super(clientID, subName, selector, durable, transactional, 
      jndiCtxFactory, connFactory, providerURL, topicName); 
  } 
 
  public void handleMsg() 
  throws CDSEventServiceSubscriberException 
  { 
    try 
    { 
      // simply prints the message 
      TextMessage txtMsg = (TextMessage) getMessage(); 
      System.out.println(txtMsg.getText()); 
    } 
    catch (Exception ex) 
    { 
      ex.printStackTrace(); 
    } 
  } 
 
  public void handleError() 
  throws CDSEventServiceSubscriberException {} 
 
  private static void displayUsage() 
  { 
    System.out.println(); 
    System.out.print("Usage :java CDSBillingSubscriber "); 
    System.out.print("clientID subName selector "); 
    System.out.print("durable transactional "); 
    System.out.print("jndiCtxFactory connFactory "); 
    System.out.print("providerURL topicName"); 
    System.out.println(); 
    System.out.println(); 
    System.out.print("For selector, you can specify null or "); 
    System.out.print("JMSCorrelationID=<event>"); 
    System.out.println(); 
    System.out.println(); 
    System.out.println("\t Terminating Program ..."); 
    System.exit(-1); 
  } 
 
  public static void main(String[] args) 
  { 
    String clientID = null; 
    String subName = null; 
    String selector = null; 
    boolean durable = false; 
    boolean transactional = false; 
    String jndiCtxFactory = null; 
    String connFactory = null; 
    String providerURL = null; 
    String topicName = null; 
    if (args.length == 9) 
    { 
      clientID = args[0]; 
      subName = args[1]; 
      selector = args[2]; 
      durable = Boolean.valueOf(args[3]).booleanValue(); 
      transactional = Boolean.valueOf(args[4]).booleanValue(); 
      jndiCtxFactory = args[5]; 
      connFactory = args[6]; 
      providerURL = args[7]; 
      topicName = args[8]; 
    } 
    else 
    { 
      displayUsage(); 
    } 
 
    if (selector == null) 
      selector = null; 
    else if (selector.trim().length() == 0) 
      selector = null; 
    else if (selector.trim().equalsIgnoreCase("null")) 
      selector = null; 
 
 
    CDSBillingSubscriber s = null; 
    try 
    { 
      System.out.println(); 
      System.out.println("Creating subscriber..."); 
      s = new CDSBillingSubscriber(clientID, subName, 
          selector, durable,transactional, jndiCtxFactory, 
          connFactory, providerURL, topicName); 
      System.out.println("Subscriber created."); 
      System.out.println("clientID="+s.getClientID()); 
      System.out.println("subName="+s.getSubName()); 
      System.out.println("selector="+s.getSelector()); 
      System.out.println("durable="+s.isDurable()); 
      System.out.println("transactional="+s.isTransactional()); 
      System.out.println("jndiCtxFactory="+s.getJndiCtxFactory()); 
      System.out.println("connFactory="+s.getConnFactory()); 
      System.out.println("providerURL="+s.getProviderURL()); 
      System.out.println("topicName="+s.getTopicName()); 
 
      System.out.println(); 
      System.out.println("Running for ten minutes..."); 
      Thread.sleep(600000); 
      System.out.println("Ten minutes have elapsed."); 
    } 
    catch (Exception e) 
    { 
      e.printStackTrace(); 
    } 
 
    try 
    { 
      System.out.println(); 
      System.out.println("Closing connections..."); 
      if (s != null) 
        s.getTopicHelper().closeConnections(); 
      System.out.println("Connections closed"); 
    } 
    catch (Exception e) 
    { 
